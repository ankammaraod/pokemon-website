#! /bin/bash

source library/generate_pokemon_cards.sh
source library/generate_sidebar.sh

function list_pokemon_types(){
    local pokemons=$1
    local type
    for pokemon_details in $pokemons
    do 
        type+="$(cut -d"|" -f3 <<< $pokemon_details) "
    done
    local types=$(tr "," " " <<< $type | tr " " "\n" | sort | uniq)
    echo $types
}

function filter_pokemons(){
    local filter=$1
    local pokemons=$2

    if [[ $filter == "all" ]]
    then
        echo $pokemons
        return
    fi
    local filtered_pokemons=$(tr " " "\n" <<< "$pokemons" | grep ".*$filter.*")

    echo $filtered_pokemons
}

function generate_webpage(){
    local pokemons=$1
    local card_template=$2
    local webpage_template=$3
    local target_dir=$4

    local types=($(list_pokemon_types "$pokemons"))
    types=(all ${types[@]})

    for type in ${types[@]}
    do
        echo "Generating $type.html"
        
        local pokemons_of_type=$(filter_pokemons $type "$pokemons")
        local cards=$(generate_pokemon_cards "$pokemons_of_type" "$card_template")

        local side_bar=$(generate_sidebar $type "${types[*]}" )

        local webpage=$(substitute "__side_bar__" "$side_bar" "$webpage_template")

        webpage=$(substitute "__pokemon_articles__" "$(echo $cards)" "$webpage")
        echo  "$webpage" > ${target_dir}/${type}.html
    done
}

function generate_site(){
    local data_file=$1
    local card_template_file=$2
    local webpage_template_file=$3
    local target_dir=$4

    local pokemons=$(tail +2 ${data_file})
    local card_template=$(cat ${card_template_file})
    local webpage_template=$(cat ${webpage_template_file})

    generate_webpage "$pokemons" "$card_template" "$webpage_template"  "$target_dir"
}
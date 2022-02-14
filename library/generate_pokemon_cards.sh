#! /bin/bash

function generate_html {
    local tag=$1; 
    local class=$2;
    local content=$3

    if [ -z "$class" ];then
        echo "<$tag>${content}</${tag}>"
        return
    fi

    echo "<$tag class=\"${class}\">${content}</${tag}>"
}

function get_field(){
    local record=$1
    local field_number=$2

    cut -d"|" -f$field_number <<< $record
}

function get_pokemon_name(){
    local record=$1
    get_field "$record" 2
}

function get_types(){
    local record=$1
    get_field "$record" 3
}

function get_speed(){
    local record=$1
    get_field "$record" 4
}

function get_hp(){
    local record=$1
    get_field "$record" 5
}

function get_base_xp(){
    local record=$1
    get_field "$record" 6
}

function get_attack(){
    local record=$1
    get_field "$record" 7
}

function get_defense(){
    local record=$1
    get_field "$record" 8
}

function get_weight(){
    local record=$1
    get_field "$record" 9
}

function substitute(){
    local searching_element=$1
    local substitution_element=$2
    local source=$3

    sed "s:${searching_element}:${substitution_element}:g" <<< "$source"
}

function generate_types_html(){
    local types=$1

    local seperated_types=$(tr "," " " <<< $types)
    local types_html
    local type title_cased_type
    for type in ${seperated_types}
    do
        title_cased_type=$(make_title_case $type) 
        types_html+="$(generate_html "div" "$type" "$title_cased_type" )";
    done
    echo "$types_html"
}

function make_title_case(){
    local word=$1
    
    local title_cased="$(tr "[:lower:]" "[:upper:]" <<< ${word:0:1})${word:1}"
    echo $title_cased
}

function create_card(){
    local pokemon=$1
    local card_template=$2

    local pokemon_name=$(get_pokemon_name $pokemon)
    local title_cased_name=$(make_title_case $pokemon_name)
    local types=$(get_types $pokemon)
    local structured_types=$(generate_types_html "$types")
    local speed=$(get_speed $pokemon)
    local hp=$(get_hp $pokemon)
    local base_xp=$(get_base_xp $pokemon)
    local attack=$(get_attack $pokemon)
    local defense=$(get_defense $pokemon)
    local weight=$(get_weight $pokemon)

    sed "s:__pokemon-name__:${pokemon_name}:g;
     s:__card-heading__:${title_cased_name}:; 
     s:__types__:${structured_types}:;
     s:__speed__:${speed}:;
     s:__hp__:${hp}:;
     s:__base-xp__:${base_xp}:;
     s:__attack__:${attack}:;
     s:__defense__:${defense}:; 
     s:__weight__:${weight}: " <<< "$card_template"
}

function generate_pokemon_cards(){
    local pokemons=$1
    local template=$2

    local pokemon 
    local cards
    for pokemon in $pokemons
    do
        cards+=$( create_card "$pokemon" "$template")
    done

    echo "$cards"
}
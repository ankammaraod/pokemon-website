#! /bin/bash

source library/generate_pokemon_cards.sh

function create_link (){
  local reference=$1;
  local content=$2;

  echo "<a href=\"${reference}\">${content}</a>"
}

function generate_sidebar(){
    local selected_type=$1
    local types=($2)
    local side_bar link class

    for type in ${types[@]}
    do
        link=$(create_link "${type}.html" "${type}")
        class="${type} selected"
        
        if [[ $type != $selected_type ]]
        then
            class=""
        fi
        list+="$(generate_html "li" "${class}" "$link")"
        
    done
    side_bar=$(generate_html "ul" "side-bar" "${list}")
    side_bar=$(generate_html "nav" "" "${side_bar}")
    
    echo $side_bar
}

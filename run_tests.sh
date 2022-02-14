#! /bin/bash
source test/generate_report.sh 

source test/test_card_generator.sh
source test/test_side_bar_generator.sh
source test/test_website_generator.sh

function all_test_cases(){
    test_cases_generate_html
    test_cases_substitute
    test_cases_get_field
    test_cases_get_pokemon_name
    test_cases_get_types
    test_cases_generate_types_html
    test_cases_get_speed
    test_cases_get_base_xp
    test_cases_get_hp
    test_cases_get_attack
    test_cases_get_defense
    test_cases_get_weight
    test_make_title_case
    test_cases_create_card
    test_cases_generate_pokemon_cards

    test_cases_create_link
    test_cases_generate_sidebar

    test_cases_list_pokemon_types
    test_cases_filter_pokemons
}

function test_pokemon_generator(){

    all_test_cases;

    IFS=$'\n';
    local tests=($(get_tests));
    IFS=" ";

    generate_report "${tests[@]}";
}

test_pokemon_generator
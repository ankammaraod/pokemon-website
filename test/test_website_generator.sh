#! /bin/bash

source test/general_test_functions.sh
source test/generate_report.sh
source library/website_generator.sh

function test_list_pokemon_types(){
    local description=$1
    local pokemons=$2
    local expected=$3

    local actual=$(list_pokemon_types "$pokemons")

    local inputs="POKEMONS=$(tr "|" ":" <<< $pokemons)"

    local test_result=$( verify_expectations "$actual" "$expected" );
    append_test_case "$test_result" " list_pokemon_types|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_list_pokemon_types(){
    local description="should seperate pokemon types from pokemon details"
    local pokemons="3|venusaur|grass,poison|80|80|236|82|83|1000 4|charmander|fire|65|39|62|52|43|85 "
    local expected="fire grass poison"
    test_list_pokemon_types "$description" "$pokemons" "$expected"
    
    local description="should remove duplications from pokemon types"
    local pokemons="3|venusaur|grass,poison|80|80|236|82|83|1000 4|charmander|fire,poison|65|39|62|52|43|85 "
    local expected="fire grass poison"
    test_list_pokemon_types "$description" "$pokemons" "$expected"
}

function test_filter_pokemons(){
    local description=$1
    local filter=$2
    local pokemons=$3
    local expected=$4

    local actual=$(filter_pokemons "$filter" "$pokemons")

    local inputs="FILTER=$filter POKEMONS=$(tr "|" ":" <<< $pokemons)"

    local test_result=$( verify_expectations "$actual" "$expected" );
    append_test_case "$test_result" " filter_pokemons|${description}|${inputs}|$(tr "|" ":" <<< ${expected})|$(tr "|" ":" <<< ${actual})";
}

function test_cases_filter_pokemons(){
    local description="should give pokemons data of given type"
    local filter="fire"
    local pokemons="3|venusaur|grass,poison|80|80|236|82|83|1000 4|charmander|fire|65|39|62|52|43|85"
    local expected="4|charmander|fire|65|39|62|52|43|85"
    test_filter_pokemons "$description" "$filter" "$pokemons" "$expected"

    local description="should give all pokemons data when given type is all"
    local filter="all"
    local pokemons="3|venusaur|grass,poison|80|80|236|82|83|1000 4|charmander|fire|65|39|62|52|43|85"
    local expected="3|venusaur|grass,poison|80|80|236|82|83|1000 4|charmander|fire|65|39|62|52|43|85"
    test_filter_pokemons "$description" "$filter" "$pokemons" "$expected"
}

function all_test_cases(){
    test_cases_list_pokemon_types
    test_cases_filter_pokemons
}

function test_website_generator(){
    all_test_cases;

    IFS=$'\n';
    local tests=($(get_tests));
    IFS=" ";

    generate_report "${tests[@]}";
}

#test_website_generator

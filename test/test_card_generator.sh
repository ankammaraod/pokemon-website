#! /bin/bash

source test/general_test_functions.sh
source test/generate_report.sh
source library/generate_pokemon_cards.sh

function test_generate_html() {
    local description=$1;
    local tag=$2;
    local class=$3;
    local content="$4";
    local expected="$5";
    local actual="$(generate_html "$tag" "$class" "$content")";

    local inputs="$tag,$class,$content";

    local test_result=$( verify_expectations "$actual" "$expected" );
    append_test_case "$test_result" " generate_html|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_generate_html() {
    local description="should add html tag to content"    
    local tag="h1"
    local class="heading"
    local content="good morning"
    local expected="<h1 class=\"heading\">good morning</h1>";
    test_generate_html "${description}" "${tag}" "${class}" "${content}" "${expected}";

    local description="should add html tag when content has tag"    
    local tag="header"
    local class="heading-wrapper"
    local content="<h1>good morning</h1>"
    local expected="<header class=\"heading-wrapper\"><h1>good morning</h1></header>"
    test_generate_html "${description}" "${tag}" "${class}" "${content}" "${expected}"

    local description="shouldn't add class attibute if class not specified"    
    local tag="h1"
    local class=""
    local content="good morning"
    local expected="<h1>good morning</h1>";
    test_generate_html "${description}" "${tag}" "${class}" "${content}" "${expected}";
}

function test_substitute(){
    local description=$1
    local searching_element=$2
    local substitution_element=$3
    local source=$4
    local expected=$5

    local actual=$( substitute "$searching_element" "$substitution_element" "$source")
    local inputs="SEARCHING_ELEMENT=$searching_element SUBSTITUTION_ELEMENT=$substitution_element SOURCE=$source"

    local test_result=$( verify_expectations "$actual" "$expected" );
    append_test_case "$test_result" " substitute|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_substitute(){
    local description="should substitute with substitution element in given source"
    local searching_element="morning"
    local substitution_element="afternoon"
    local source="Hello Good morning"
    local expected="Hello Good afternoon"
    test_substitute "$description" "$searching_element" "$substitution_element" "$source" "$expected"
}


function test_get_field(){
    local description=$1
    local field_number=$2
    local record=$3
    local expected=$4

    local actual=$( get_field "$record" $field_number)
    local inputs="FIELD_NUMBER=$field_number RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_field|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_field(){
    local description="should give field of given field number"
    local field_number="2"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="ivysaur"
    test_get_field "$description" "$field_number" "$record" "$expected"
}

function test_get_pokemon_name(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_pokemon_name "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_pokemon_name|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_pokemon_name(){
    local description="should give the name of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="ivysaur"
    test_get_pokemon_name "$description" "$record" "$expected"
}

function test_get_types(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_types "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_types|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_types(){
    local description="should give the types of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="grass,poison"
    test_get_types "$description" "$record" "$expected"
}

function test_generate_types_html(){
    local description=$1
    local types=$2
    local expected=$3

    local actual=$( generate_types_html "$types")

    local inputs="TYPES=$types"
    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " generate_types_html|${description}|${inputs}|${expected}|${actual}";    
}

function test_cases_generate_types_html(){
    local description="should generate html tag for single type"
    local type="poison"
    local expected="<div class=\"poison\">Poison</div>"
    test_generate_types_html "$description" "$type" "$expected"
    
    local description="should generate html tag for multiple types"
    local type="poison,grass"
    local expected="<div class=\"poison\">Poison</div><div class=\"grass\">Grass</div>"
    test_generate_types_html "$description" "$type" "$expected"
}

function test_get_speed(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_speed "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_speed|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_speed(){
    local description="should give the speed of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="60"
    test_get_speed "$description" "$record" "$expected"
}

function test_get_hp(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_hp "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_hp|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_hp(){
    local description="should give the hp of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="60"
    test_get_hp "$description" "$record" "$expected"
}

function test_get_base_xp(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_base_xp "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_base_xp|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_base_xp(){
    local description="should give the base_xp of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="142"
    test_get_base_xp "$description" "$record" "$expected"
}

function test_get_attack(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_attack "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_attack|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_attack(){
    local description="should give the attack of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="62"
    test_get_attack "$description" "$record" "$expected"
}

function test_get_defense(){
    local description=$1
    local record=$2
    local expected=$3

    local actual=$( get_defense "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_defense|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_defense(){
    local description="should give the defense of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="63"
    test_get_defense "$description" "$record" "$expected"
}

function test_get_weight(){
    local description=$1
    local record=$2
    local expected=$3
    local actual=$( get_weight "$record" )
    local inputs="RECORD=$record"

    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " get_weight|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_get_weight(){
    local description="should give the weight of pokemon from pokemon details"
    local record="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local expected="130"
    test_get_weight "$description" "$record" "$expected"
}

function test_make_title_case(){
    local description="should change the first letter of word to uppercase"
    local word="sai"
    local expected="Sai"

    local actual=$(make_title_case "$word")

    local inputs="WORD=$word"
    local test_result=$( verify_expectations "$actual" "$expected" )
    append_test_case "$test_result" " make_title_case|${description}|${inputs}|${expected}|${actual}"
}

function test_create_card(){
    local description=$1
    local pokemon_details=$2
    local template=$3
    local expected_file=$4
    local actual_file="test/test_data/test_create_card_actual"
    create_card "$pokemon_details" "$template" > $actual_file

    local actual
    diff $actual_file $expected_file > /dev/null
    actual=$(echo $?)
    local test_result=$(verify_expectations "$actual" "0")

    local inputs="POKEMON_DETAILS=$(tr "|" "," <<< $pokemon_details) HTML_TEMPLATE=$(tr "\n" " " <<< $template)"
    append_test_case "$test_result" " create_card|$description|$inputs|$expected_file|$actual_file"
}

function test_cases_create_card(){
    local description="should create card for pokemon"
    local pokemon_details="2|ivysaur|grass,poison|60|60|142|62|63|130"
    local template="<article class=\"pokemon\">
    <div class=\"pokemon-img\">
        <img src=\"images/__pokemon-name__.png\" alt=\"__pokemon-name__\">
    </div>
    <section class=\"pokemon-details\">
        <header>
            <h1>__card-heading__</h1>
            <div class=\"type\">
                __types__
            </div>
        </header>
        <table class=\"stats\">
            <tr>
                <th>Weight</th>
                <td>__weight__</td>
            </tr>
            <tr>
                <th>Base XP</th>
                <td>__base-xp__</td>
            </tr>
            <tr>
                <th>HP</th>
                <td>__hp__</td>
            </tr>
            <tr>
                <th>Attack</th>
                <td>__attack__</td>
            </tr>
            <tr>
                <th>Defense</th>
                <td>__defense__</td>
            </tr>
            <tr>
                <th>Speed</th>
                <td>__speed__</td>
            </tr>
        </table>
    </section>
</article>"
    local expected="test/test_data/test_create_card_expected"
    test_create_card "$description" "$pokemon_details" "$template" "$expected"
}

function test_generate_pokemon_cards(){
    local description=$1
    local pokemons=$2
    local template=$3
    local expected_file=$4
    local actual_file="test/test_data/test_generate_pokemon_cards_actual"
    generate_pokemon_cards "$pokemons" "$template" > $actual_file
    
    local actual
    diff $actual_file $expected_file > /dev/null
    actual=$(echo $?)
    local test_result=$(verify_expectations "$actual" "0")

    local inputs="POKEMONS=$(tr "|" "," <<< $pokemons) TEMPLATE=$(tr "\n"  " " <<< $template)"
    append_test_case "$test_result" " generate_pokemon_cards|$description|$inputs|$expected_file|$actual_file"
}

function test_cases_generate_pokemon_cards(){
    local description="should create cards for more than pokemons"
    local pokemon_details="3|venusaur|grass,poison|80|80|236|82|83|1000 4|charmander|fire|65|39|62|52|43|85"
    local template="<article class=\"pokemon\">
    <div class=\"pokemon-img\">
        <img src=\"images/__pokemon-name__.png\" alt=\"__pokemon-name__\">
    </div>
    <section class=\"pokemon-details\">
        <header>
            <h1>__card-heading__</h1>
            <div class=\"type\">
                __types__
            </div>
        </header>
        <table class=\"stats\">
            <tr>
                <th>Weight</th>
                <td>__weight__</td>
            </tr>
            <tr>
                <th>Base XP</th>
                <td>__base-xp__</td>
            </tr>
            <tr>
                <th>HP</th>
                <td>__hp__</td>
            </tr>
            <tr>
                <th>Attack</th>
                <td>__attack__</td>
            </tr>
            <tr>
                <th>Defense</th>
                <td>__defense__</td>
            </tr>
            <tr>
                <th>Speed</th>
                <td>__speed__</td>
            </tr>
        </table>
    </section>
</article>
"
    local expected="test/test_data/test_generate_pokemon_cards_expected"
    test_generate_pokemon_cards "$description" "$pokemon_details" "$template" "$expected"
}

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
}

function test_card_generator(){
    all_test_cases;

    IFS=$'\n';
    local tests=($(get_tests));
    IFS=" ";

    generate_report "${tests[@]}";
}

#test_card_generator
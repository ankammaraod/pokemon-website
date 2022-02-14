#! /bin/bash

source test/general_test_functions.sh
source test/generate_report.sh
source library/generate_sidebar.sh

function test_create_link(){
    local description=$1
    local content=$2
    local reference=$3
    local expected=$4

    local actual=$(create_link "$reference" "$content")

    local inputs="REFERENCE=$reference CONTENT=$content"

    local test_result=$( verify_expectations "$actual" "$expected" );
    append_test_case "$test_result" " create_link|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_create_link() {
    local description="should create link with reference for given content"
    local content="wikipedia"
    local reference="www.wikipedia.org/"
    local expected="<a href=\"www.wikipedia.org/\">wikipedia</a>"

    test_create_link "$description" "$content" "$reference" "$expected"
}

function test_generate_sidebar(){
    local description=$1
    local selected_type=$2
    local types=$3
    local expected=$4

    local actual=$( generate_sidebar "$selected_type" "$types" )
    local inputs="SELECTED_TYPE=$selected_type TYPES=$types"

    local test_result=$( verify_expectations "$actual" "$expected" );
    append_test_case "$test_result" " generate_sidebar|${description}|${inputs}|${expected}|${actual}";
}

function test_cases_generate_sidebar(){
    local description="should add classes for selected type and create sidebar "
    local selected_type="all"
    local types="all posion"
    local expected="<nav><ul class=\"side-bar\"><li class=\"all selected\"><a href=\"all.html\">all</a></li><li><a href=\"posion.html\">posion</a></li></ul></nav>"
    test_generate_sidebar "$description" "$selected_type" "$types" "$expected"
    
    local description="should create sidebar for single type"
    local selected_type="all"
    local types="all"
    local expected="<nav><ul class=\"side-bar\"><li class=\"all selected\"><a href=\"all.html\">all</a></li></ul></nav>"
    test_generate_sidebar "$description" "$selected_type" "$types" "$expected"

    local description="should create sidebar for multiple types"
    local selected_type="all"
    local types="all posion"
    local expected="<nav><ul class=\"side-bar\"><li class=\"all selected\"><a href=\"all.html\">all</a></li><li><a href=\"posion.html\">posion</a></li></ul></nav>"
    test_generate_sidebar "$description" "$selected_type" "$types" "$expected"
}

function all_test_cases(){
    test_cases_create_link
    test_cases_generate_sidebar
}

function test_side_bar_generator(){
    all_test_cases;

    IFS=$'\n';
    local tests=($(get_tests));
    IFS=" ";

    generate_report "${tests[@]}";
}

#test_side_bar_generator
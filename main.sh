#! /bin/bash

source library/website_generator.sh

data_file="database/pokemon.csv" 
card_template_file="html_template/card_template.html"
webpage_template_file="html_template/website_template.html"
target_dir="html"

rm -rf ${target_dir}/*.html

generate_site ${data_file} ${card_template_file} ${webpage_template_file} ${target_dir}

open ${target_dir}/all.html
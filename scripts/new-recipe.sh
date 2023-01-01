#!/bin/bash
set -euo pipefail

RECIPE_ROOT_PATH='./recettes/'
TEMPLATE_FILE_PATH='./scripts/recipe_template.md'
RECIPE_FILE_EXTENSION='.md'

# input folder name in which the recipe should be created
folders=()
for folder in $(ls ${RECIPE_ROOT_PATH}); do
    folders+=(${folder})
done

echo "In which folder should the recipe be created?"
for (( i=0; i<${#folders[@]}; i++ )); do
    # listing choices
    echo "- '${i}' for '${folders[i]}/'"
done
folder_idx=0
read -p "[default: ${folder_idx}]: " folder_idx
if [[ ! "${folder_idx}" =~ ^[0-9]*$ ]] || [[ ! "${folder_idx}" -ge 0 ]] || [[ ! "${folder_idx}" -lt "${#folders[@]}" ]]; then
    echo "Invalid input: ${folder_idx}"
    exit 1
fi
folder=${folders[folder_idx]}

# input recipe file name
read -p 'Recipe file name (with no extension): ' file_name
if [[ ! "${file_name}" =~ ^[a-z0-9_]*$ ]]; then
    echo "Recipe file name should be small letters with underscores, no extension"
    exit 1
fi

# copying the template into the new recipe file
echo "Creating recipe '${file_name}${RECIPE_FILE_EXTENSION}' in '${folder}'"
cp ${TEMPLATE_FILE_PATH} "${RECIPE_ROOT_PATH}/${folder}/${file_name}${RECIPE_FILE_EXTENSION}"

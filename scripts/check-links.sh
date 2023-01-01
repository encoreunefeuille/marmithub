#!/bin/bash
set -euo pipefail

FOLDERS=(
    './recettes/sucrees/'
    './recettes/salees/'
)
EXTENSION='.md'

exit_code=0
for folder in ${FOLDERS[@]}; do
    # echo "Checking folder ${folder}"
    for file in $(ls ${folder} | grep ${EXTENSION}); do
        file_path=${folder}${file}
        # echo "Checking file ${file_path}"
        if [[ ! "$(cat README.md | grep -c ${file_path})" -eq 1 ]]; then
            echo "No link found for file ${file_path}" 
            exit_code=1
        fi
    done
done
echo "Returning exit code $exit_code"
exit $exit_code

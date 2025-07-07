#!/bin/bash

META_DIR="$HOME/.trash/meta"

printf "%-36s | %-20s | %-50s | %-19s\n" "UUID" "Name" "Original Path" "Deleted At"
printf -- "----------------------------------------------------------------------------------------------------------\n"

for FILE in "$META_DIR"/*.json; do
  jq -r '[.uuid, .name, .original_path, .deleted_at] | @tsv' "$FILE" | awk -F'\t' '{printf "%-36s | %-20s | %-50s | %-19s\n", $1, $2, $3, $4}'
done



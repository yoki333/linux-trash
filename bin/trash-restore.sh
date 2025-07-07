#!/bin/bash

UUID="$1"
META_DIR="$HOME/.trash/meta"
FILE_DIR="$HOME/.trash/files"

META_FILE="$META_DIR/$UUID.json"
[ ! -f "$META_FILE" ] && echo "UUID $UUID not found" && exit 1

ORIGINAL_PATH=$(jq -r '.original_path' "$META_FILE")
FILENAME=$(jq -r '.name' "$META_FILE")

mkdir -p "$(dirname "$ORIGINAL_PATH")"
mv "$FILE_DIR/$UUID" "$ORIGINAL_PATH"
rm "$META_FILE"



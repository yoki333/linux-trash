#!/bin/bash

META_DIR="$HOME/.trash/meta"
FILE_DIR="$HOME/.trash/files"
NOW=$(date +%s)

for METAFILE in "$META_DIR"/*.json; do
  UUID=$(basename "$METAFILE" .json)
  DELETE_TIME=$(jq -r '.deleted_at' "$METAFILE")
  DELETE_TIMESTAMP=$(date -d "$DELETE_TIME" +%s)

  AGE=$(( (NOW - DELETE_TIMESTAMP) / 86400 ))
  if [ "$AGE" -gt 3 ]; then
    rm -f "$FILE_DIR/$UUID" "$METAFILE"
  fi
done



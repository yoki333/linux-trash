o#!/bin/bash

TRASH_DIR="$HOME/.trash"
FILE_DIR="$TRASH_DIR/files"
META_DIR="$TRASH_DIR/meta"

mkdir -p "$FILE_DIR" "$META_DIR"

for TARGET in "$@"; do
  for FILE in $(compgen -G "$TARGET"); do
    [ ! -e "$FILE" ] && continue

    UUID=$(uuidgen)
    BASENAME=$(basename "$FILE")
    DEST="$FILE_DIR/$UUID"
    METAFILE="$META_DIR/$UUID.json"

    # 获取元信息
    FILE_TYPE=$(file -b "$FILE")
    ORIGIN_PATH=$(realpath "$FILE")
    SIZE=$(du -b "$FILE" | cut -f1)
    TIME=$(date "+%Y-%m-%d %H:%M:%S")

    # 处理软链接
    if [ -L "$FILE" ]; then
      LINK_TARGET=$(readlink "$FILE")
    else
      LINK_TARGET=""
    fi

    # 移动文件
    mv "$FILE" "$DEST"

    # 写入元信息
    jq -n --arg uuid "$UUID" \
          --arg name "$BASENAME" \
          --arg path "$ORIGIN_PATH" \
          --arg time "$TIME" \
          --arg size "$SIZE" \
          --arg type "$FILE_TYPE" \
          --arg link "$LINK_TARGET" \
          '{
            uuid: $uuid,
            name: $name,
            original_path: $path,
            deleted_at: $time,
            size: $size,
            type: $type,
            symlink_target: $link
          }' > "$METAFILE"
  done
done



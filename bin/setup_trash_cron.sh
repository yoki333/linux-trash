#!/bin/bash

# === 跳过 root 用户 ===
if [ "$EUID" -eq 0 ]; then
  return 0
fi

CRON_MARKER="# Added by linux-trash"
CRON_LINE="0 3 */3 * * bash \$HOME/.local/bin/trash-clean.sh $CRON_MARKER"

# === 检查当前 crontab 是否已添加相同标记 ===
crontab -l 2>/dev/null | grep -F "$CRON_MARKER" >/dev/null
if [ $? -ne 0 ]; then
  (crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
fi



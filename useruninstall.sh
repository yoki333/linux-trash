#!/bin/bash

echo "🧹 正在卸载 linux-trash（当前用户）..."

TRASH_MARK="# ========== Trash override =========="
BASHRC="$HOME/.bashrc"
BIN_DIR="$HOME/.local/bin"
TRASH_DIR="$HOME/.trash"

# 1. 从 .bashrc 中移除 override 块
if grep -q "$TRASH_MARK" "$BASHRC"; then
  echo "✂️  移除 ~/.bashrc 中的回收站配置..."
  sed -i '/# ========== Trash override ==========/,/# ========== Trash end ==========/{d}' "$BASHRC"
else
  echo "ℹ️  ~/.bashrc 中未发现回收站配置，跳过"
fi

# 2. 删除脚本文件
echo "🗑️  删除 ~/.local/bin 中的回收站脚本..."
rm -f "$BIN_DIR"/trash-*.sh
rm -f "$BIN_DIR"/setup_trash_cron.sh
rm -f "$BIN_DIR"/welcome_trash_notice.sh

# 3. 删除 .trash 目录
echo "🗑️  删除 ~/.trash ..."
rm -rf "$TRASH_DIR"

# 4. 清除 cron 中的自动清理任务
echo "⚙️  移除 crontab 中的 trash-clean.sh 条目..."
crontab -l 2>/dev/null | grep -v "trash-clean.sh" | crontab -

echo "✅ linux-trash 已从当前用户环境中卸载。"
echo "💡 建议你运行：source ~/.bashrc 或重新登录以生效"


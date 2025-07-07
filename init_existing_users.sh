#!/bin/bash

echo "🛠️ 为现有用户批量初始化 linux-trash 配置..."

SKEL_BIN_DIR="/etc/skel/.local/bin"
TRASH_MARK="# ========== Trash override =========="

for home in /home/*; do
  [ -d "$home" ] || continue
  username=$(basename "$home")

  echo "🔧 配置用户: $username"

  # 1. 初始化 ~/.trash
  mkdir -p "$home/.trash/files" "$home/.trash/meta"
  chown -R "$username:$username" "$home/.trash"

  # 2. 复制脚本
  mkdir -p "$home/.local/bin"
  cp -u $SKEL_BIN_DIR/*.sh "$home/.local/bin/"
  chown -R "$username:$username" "$home/.local/bin"

  # 3. 修改 .bashrc
  bashrc="$home/.bashrc"
  if ! grep -q "$TRASH_MARK" "$bashrc"; then
    echo "" >> "$bashrc"
    cat << 'EOF' >> "$bashrc"

# ========== Trash override ==========
rm() {
  bash ~/.local/bin/trash-put.sh "$@"
}

alias restore='bash ~/.local/bin/trash-restore.sh'
alias trash-list='bash ~/.local/bin/trash-list.sh'
# ========== Trash end ==========

EOF
    chown "$username:$username" "$bashrc"
  else
    echo "ℹ️  $username 的 .bashrc 已包含 Trash 配置，跳过"
  fi

  # 4. 添加定时清理任务（不重复）
  CRON_MARKER="# Added by linux-trash"
  CRON_LINE="0 3 */3 * * bash \$HOME/.local/bin/trash-clean.sh $CRON_MARKER"

  su - "$username" -c "
    crontab -l 2>/dev/null | grep -F \"$CRON_MARKER\" >/dev/null
    if [ \$? -ne 0 ]; then
      (crontab -l 2>/dev/null; echo \"$CRON_LINE\") | crontab -
    fi
  "
done

echo "✅ 所有现有用户已完成 linux-trash 配置。"


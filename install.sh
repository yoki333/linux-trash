#!/bin/bash

echo "🔧 开始安装 linux-trash 环境..."

# === 1. 创建 skel 中的 ~/.trash/ 结构 ===
echo "📁 创建 /etc/skel/.trash 目录结构..."
mkdir -p /etc/skel/.trash/files
mkdir -p /etc/skel/.trash/meta

# === 2. 拷贝脚本到 skel 中的 ~/.local/bin ===
echo "📄 拷贝脚本到 /etc/skel/.local/bin ..."
mkdir -p /etc/skel/.local/bin
cp -v ./bin/*.sh /etc/skel/.local/bin/

# === 3. 安装自动配置 cron 的脚本到 /etc/profile.d/（root权限）===
echo "📂 安装登录时自动添加 cron 脚本到 /etc/profile.d/ ..."
cp -v ./bin/setup_trash_cron.sh /etc/profile.d/
chmod +x /etc/profile.d/setup_trash_cron.sh

# === 4. 修改 /etc/skel/.bashrc，追加 trash 函数定义（避免重复）===
if ! grep -q "Trash override" /etc/skel/.bashrc; then
  echo "✏️ 向 /etc/skel/.bashrc 添加 rm、restore、trash-list..."
  echo "" >> /etc/skel/.bashrc   # 确保前一行有换行
  cat << 'EOF' >> /etc/skel/.bashrc

# ========== Trash override ==========
rm() {
  bash ~/.local/bin/trash-put.sh "$@"
}

alias restore='bash ~/.local/bin/trash-restore.sh'
alias trash-list='bash ~/.local/bin/trash-list.sh'
# ========== Trash end ==========

EOF
else
  echo "⚠️  /etc/skel/.bashrc 已包含 Trash 配置，跳过追加"
fi

# === 5. 安装欢迎提示脚本到 /etc/profile.d/ ===
echo "📢 安装每次登录欢迎提示脚本..."
cp -v ./bin/welcome_trash_notice.sh /etc/profile.d/
chmod +x /etc/profile.d/welcome_trash_notice.sh

echo "✅ linux-trash 安装完成，新建用户登录后将自动启用回收站功能。"


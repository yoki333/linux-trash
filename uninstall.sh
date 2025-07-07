#!/bin/bash

echo "🧹 正在卸载 linux-trash（系统级）..."

# 1. 移除 /etc/skel/.bashrc 中配置
if grep -q "Trash override" /etc/skel/.bashrc; then
  sed -i '/# ========== Trash override ==========/,/# ========== Trash end ==========/{d}' /etc/skel/.bashrc
  echo "✂️  已移除 /etc/skel/.bashrc 配置"
fi

# 2. 删除 skel 目录下脚本和回收站结构
rm -rf /etc/skel/.local/bin/trash-*.sh
rm -rf /etc/skel/.trash
echo "🗑️  已清理 /etc/skel/ 下脚本和目录"

# 3. 删除 profile.d 中脚本
rm -f /etc/profile.d/setup_trash_cron.sh
rm -f /etc/profile.d/welcome_trash_notice.sh
echo "🗑️  已删除 /etc/profile.d 中脚本"

echo "✅ 卸载完成。当前已安装用户可使用 useruninstall.sh 自行清理。"


#!/bin/bash

# 只对非 root 用户执行
if [ "$EUID" -eq 0 ]; then
  return 0
fi

# 显示提示信息（每次登录都显示）
echo -e "\033[1;32m📦  欢迎使用 Linux 回收站功能！\033[0m"
echo -e "\033[1;36m  - 删除文件请直接使用 rm（已被自动接管）"
echo -e "  - 恢复文件请使用：restore <UUID>"
echo -e "  - 使用 trash-list 命令查看 UUID（用于恢复）"
echo -e "\033[1;33m  ⚠️  回收站每三天会自动清理一次，请及时恢复重要文件。\033[0m"
#echo -e "  - 查看元数据文件：~/.trash/meta/*.json\033[0m"
echo ""



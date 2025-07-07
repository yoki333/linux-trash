# linux-trash
一个轻量、用户级的 Linux 回收站实现，支持多版本恢复、元信息记录、自动清理等功能。适用于误删防护，不影响系统行为。

## ✨ 功能特色

- ✅ 替代 `rm`，保留原始删除行为
- ✅ 支持 `rm -rf test*` 等通配符
- ✅ 多次删除不冲突（通过 UUID 区分）
- ✅ 支持普通文件、目录、软链接
- ✅ 元信息记录（原路径、删除时间、文件类型等）
- ✅ 可筛选恢复历史版本
- ✅ 用户隔离，仅普通用户使用
- ✅ 可通过 cron 自动清理过期回收内容

## 📦 安装方法

```bash
git clone https://github.com/yourname/linux-trash.git
cd linux-trash
bash install.sh

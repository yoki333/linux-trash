# linux-trash
一个轻量、用户级的 Linux 回收站实现，支持多版本恢复、元信息记录、自动清理等功能。适用于误删防护，不影响系统行为。

---

## ✨ 功能特性

| 功能                       | 说明                               |
| ------------------------ | -------------------------------- |
| ✅ 多次删除不冲突                | 文件名中加入 UUID 实现多版本管理              |
| ✅ 记录完整元信息                | 保存原路径、删除时间、大小、类型、软链接目标等（JSON 格式） |
| ✅ 支持软链接 / 目录 / 普通文件      | 统一处理各种文件类型                       |
| ✅ 支持 `rm -rf test*` 等通配符 | 正确处理参数展开与递归                      |
| ✅ 恢复时可选择具体版本             | 通过 UUID 或路径筛选版本恢复                |
| ✅ 用户隔离，禁止 root 使用        | 每个用户独立存储于 `~/.trash/`，root 默认不启用 |
| ✅ 每三天自动清理回收站             | 使用 `cron` 定时清理旧文件（可自定义）          |
| ✅ 登录欢迎提示+命令提示            | 友好的首次使用说明                        |
| ✅ 支持已有用户和新用户一键部署         | 提供全自动配置脚本                        |

---

## 📂 项目结构

```
linux-trash/
├── bin/                        # 所有核心功能脚本
│   ├── trash-put.sh            # 替代 rm 命令
│   ├── trash-restore.sh        # 文件恢复功能
│   ├── trash-list.sh           # 查看已删除文件及 UUID
│   ├── trash-clean.sh          # 自动清理脚本
│   ├── setup_trash_cron.sh     # 添加定时任务
│   └── welcome_trash_notice.sh # 登录提示
├── install.sh                  # 安装（新用户模板）
├── uninstall.sh                # 卸载系统配置
├── useruninstall.sh            # 当前用户卸载回收站功能
├── init_existing_users.sh      # 为已有用户批量初始化配置
├── LICENSE                     # MIT 开源许可
└── README.md                   # 本文件
```

---

## 🚀 安装方法（管理员执行）

```bash
git clone https://github.com/yourname/linux-trash.git
cd linux-trash
sudo bash install.sh                 # 安装脚本和用户模板
sudo bash init_existing_users.sh    # 可选：初始化所有已存在用户
```

✅ 安装后：

* 所有新创建用户将自动启用回收站功能；
* 老用户登录后将自动添加定时清理任务；
* 所有用户首次登录会看到欢迎提示。

---

## 🧰 使用方法（普通用户）

```bash
rm myfile.txt                   # 删除文件（自动移动到 ~/.trash）
trash-list                      # 查看被删除文件列表及 UUID
restore <UUID>                 # 恢复指定文件（通过 UUID）
```

📌 注意：

* 支持通配符删除，如：`rm -rf data*`
* 恢复后的文件保存在原路径，如原路径不存在则提示错误

---

## 🔁 卸载方法

### 🣍 当前用户卸载

```bash
bash useruninstall.sh
```

将移除：

* `~/.bashrc` 中的 alias 和函数定义
* `~/.trash/` 数据目录
* `~/.local/bin/trash-*.sh` 脚本
* 当前用户的 `crontab` 自动清理任务

---

### 👨‍💼 系统级卸载（管理员）

```bash
sudo bash uninstall.sh
```

将移除：

* `/etc/skel/` 下模板配置
* `/etc/profile.d/` 中的脚本
* 所有新用户将不再自动配置回收站

---

## 📝 开源协议

本项目采用 [MIT License](./LICENSE) 开源协议。
你可以自由使用、修改、分发本工具，但请保留原作者版权声明。

---

## 🤝 致谢

> 本项目在开发过程中借助 [ChatGPT](https://chat.openai.com) 进行代码逻辑构思与文档优化。

---

## 📢 联系我

如有建议、Bug 或希望功能扩展，欢迎通过 GitHub Issue 或 PR 与我联系！


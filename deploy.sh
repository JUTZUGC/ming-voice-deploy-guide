#!/usr/bin/env bash
set -euo pipefail
# Ming Voice 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/JMS1717/ming-voice#quick-start
# 更新日期：2026-10-30
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

curl -fsSL https://raw.githubusercontent.com/JMS1717/ming-voice/main/install.sh | bash
echo "安装完成：从应用菜单打开 Ming Voice，首次启动要 1–2 分钟编译内核"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/JMS1717/ming-voice#quick-start"

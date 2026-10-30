# Ming Voice 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/JMS1717/ming-voice#quick-start
# 更新日期：2026-10-30
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

irm https://raw.githubusercontent.com/JMS1717/ming-voice/main/install.ps1 | iex
Write-Host "安装完成：桌面会出现 Ming Voice 快捷方式，首次启动要 1–2 分钟编译内核"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/JMS1717/ming-voice#quick-start'

# Ming Voice 一键部署指南

> 第三方部署指南 · 非 Ming Voice 官方仓库。官方项目：[JMS1717/ming-voice](https://github.com/JMS1717/ming-voice)
> 内容来自官方文档（2026-10-30）。项目迭代快，请以[官方文档](https://github.com/JMS1717/ming-voice#quick-start)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 声音不出本机：识别、思考、合成都在自己的显卡上跑，说完四分之一秒就开始回答。

⚠️ 门槛在硬件：需要 16 GB 以上显存的 GPU（AMD RX 6800 起，NVIDIA RTX 30 系起且标注实验性），约 30 GB 空闲磁盘，模型本身约 20 GB。Windows 需要 11 并通过 WSL2 运行，安装器会自动装 Ubuntu 24.04。首次启动要 1–2 分钟编译内核。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/ming-voice-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会先确认显卡与磁盘，再跑官方安装脚本，自动装驱动依赖、下载模型并建好启动项，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Ming Voice 是什么？

Ming Voice 是开源的完全本地的实时语音助手：说完约 0.23 秒就开口回答，能查天气、搜网页、记清单、控智能家居（协议：MIT，<img src="https://img.shields.io/github/stars/JMS1717/ming-voice?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把语音转语音模型做成常驻助手：本地判断你是否说完、打断可接管、回答直接用扬声器播出，还能调工具查天气搜网页、管清单与定时器、控制 Home Assistant 与 Jellyfin。

- 完全本地：音频不出本机，工具关闭后彻底离线
- 低延迟：说完约 0.23 秒开始回答
- 能被打断：边说边改，一秒内继续说话会合并成一轮
- 工具齐全：天气、搜索、计算器、定时器、清单、记忆
- 智能家居：Home Assistant 灯光、空调、门锁、扫地机
- 多端接入：手机网页、Wyoming 协议、OpenAI 兼容 API

（来源：[官方仓库](https://github.com/JMS1717/ming-voice)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 398 stars 10 月新项目 | 名称搜索仅 8 条结果 |
| 完全本地 | 音频不出机器 |
| 延迟低 | 可随时打断 |
| 工具链完整 | 搜索、天气、清单、定时器 |
| 能接 Home Assistant 与 Jellyfin | — |
| MIT 协议 | 可改可二开 |

| 需要注意 | 说明 |
|---|---|
| 硬件门槛高 | 16 GB 显存 + 30 GB 磁盘 |
| Windows 必须走 WSL2 | — |
| 首次启动还要等内核编译 | — |
| NVIDIA 路径标注实验性 | — |
| 模型下载约 20 GB | 占带宽 |

> 以上基于官方文档与社区反馈整理（2026-10-30），以官方最新文档为准。

## 快速部署（官方方式）

```bash
curl -fsSL https://raw.githubusercontent.com/JMS1717/ming-voice/main/install.sh | bash
echo "安装完成：从应用菜单打开 Ming Voice，首次启动要 1–2 分钟编译内核"
```

部署步骤来源：[https://github.com/JMS1717/ming-voice#quick-start](https://github.com/JMS1717/ming-voice#quick-start)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 16 GB 显存、30 GB 磁盘与 Linux / WSL2 要求 | 已核对 2026-10-30 |
| README 确认 install.sh / install.ps1 两条安装入口 | 已核对 2026-10-30 |
| 未实测安装（需 16 GB 显存与约 20 GB 模型下载） | 说明 2026-10-30 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-30 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-30 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装步骤、硬件要求与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-30）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\ming-voice-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装前先确认

| 项目 | 要求 |
|---|---|
| 显卡 | 16 GB 以上显存；AMD RX 6800 起（7000 / 9000 系与 PRO 卡），NVIDIA RTX 30 系起（实验性） |
| 磁盘 | 约 30 GB（模型 20 GB + Python 环境） |
| 系统 | Linux x86_64，或 Windows 11 + WSL2 |
| 内存占用 | bf16 约 20.5 GB 显存；23 GB 以下的卡会自动用 int8 专家，约 12.5 GB |

## 安装

**Linux**：

```bash
curl -fsSL https://raw.githubusercontent.com/JMS1717/ming-voice/main/install.sh | bash
```

**Windows**（PowerShell）：

```powershell
irm https://raw.githubusercontent.com/JMS1717/ming-voice/main/install.ps1 | iex
```

Windows 版会自动装 WSL 与 Ubuntu 24.04，AMD 卡还会装 ROCm，然后在桌面放一个快捷方式。中途断了直接重跑，已完成的步骤会跳过。想换目录就设 `MING_DIR`。

## 第一次使用

1. 从应用菜单（Windows 是桌面快捷方式）打开
2. 等首次启动完成内核编译
3. 授权麦克风，直接说话试试；也可以在设置里切到唤醒词模式「Hey Ming」
4. 手机在同一局域网用 HTTPS 打开同一个页面，可添加到主屏幕

## 常用能力

- **唤醒词 / 免手 / 按住说话** 三种模式
- **工具**：天气、网页搜索、计算器、时钟
- **清单与记忆**：「我把车停在三层」这类信息会被记住
- **Home Assistant**：灯、插座、空调、门锁、扫地机、场景，支持「二十分钟后关灯」
- **Jellyfin** 与 **Hermes Agent** 接力

## 注意

- 显存不足会直接起不来，先看自己的卡
- 默认模型约 20 GB，下载时间长，建议有线网络
- AMD 安装时要加进 `render` 组，装完需要重新登录一次
- 工具开着时会向外发搜索词与地名，想全离线就在设置里关掉
- NVIDIA 标注为实验性，16 GB 卡还没实测

## 常见坑

- 显存不足：换 16 GB 以上的卡，或用 int8 专家模式
- 安装中断：直接重跑安装脚本，已完成步骤会跳过
- AMD 权限问题：安装器会把你加进 render 组，重新登录才生效
- Windows 没有 WSL：安装器会自动装，但需要管理员权限与重启
- 首次启动卡住：在编译内核，等 1–2 分钟
- 搜不到模型：检查磁盘空间与网络，必要时设 MING_DIR 换盘
- 想彻底离线：设置里关掉工具，避免搜索词外发

## 免责声明

本仓库为第三方指南，与 Ming Voice 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-30），项目迭代快，请以[官方文档](https://github.com/JMS1717/ming-voice#quick-start)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。

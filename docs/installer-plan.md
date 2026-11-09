# SolOS 图形安装器与自动配置生成策划书

版本：草案 1.3（2026-11-09）
依据：仓库 `main` 的 `a0f3906`、锁定版本的上游 Calamares 配置与 NixOS 手册。本文件保留最初的完整方案评估；第 2 节的“仓库现状”描述的是实施前基线。

实施进度：最小范围的 SolOS 安装目标、flake 交接和 Niri／KDE／COSMIC 桌面选择已经接入；当前验收记录与支持边界见 [`installer/README.md`](../installer/README.md)。下文完整方案中的离线安装、加密和更多分区组合仍属于后续阶段。

## 1. 目标与交付边界

交付一个可从 ISO 启动、通过 Calamares 完成安装、首次重启进入 SolOS、并在目标机器上保留可继续维护的 Nix flake 的 x86_64 安装器。安装时采集的磁盘布局、硬件、用户名、主机名、语言、时区、键盘和桌面选择，应成为目标系统的配置，而不是沿用开发者机器的配置。

**已明确的实施方向：沿用 NixOS 原版 Calamares 的安装逻辑；目标系统默认采用 flake；安装器的桌面选择仅对应仓库 `mods/gui` 下预设的 Niri、KDE 和 COSMIC。** Live ISO 可以继续使用 GNOME，Live 桌面不决定安装后的桌面。

“完整方案”支持以下**经过定义的场景**，不等于任意选项的所有排列组合都已验证：

- 固件：UEFI；传统 BIOS 使用 GPT 和 BIOS boot 分区。
- 磁盘：整盘安装；手动分区；在已有系统旁使用预留的空闲空间安装。默认不自动缩小现有 Windows 分区。
- 文件系统：ext4 或 Btrfs；可选 LUKS 根分区加密；EFI 系统分区保持未加密。
- 安装来源：联网和断网安装。断网模式须在断网虚拟机中实际完成安装。
- 安装结果：Niri、KDE Plasma、COSMIC 可选；只在定义的组合中验证桌面启动。
- 目标配置：生成 `hardware-configuration.nix`、机器专属模块、用户模块和锁定依赖版本的 `flake.lock`；可在安装后执行常规 `nixos-rebuild`。

不纳入本轮：aarch64 ISO、自动缩小 Windows 分区、休眠、任意 RAID/ZFS 布局、所有显卡型号的定制驱动、OEM 批量部署、从旧系统自动迁移个人数据。这些可单独选购；见第 6 节。默认使用 ZRAM；有磁盘 swap 时只保证正常交换，不生成 `resumeDevice`。

## 2. 仓库现状与关键缺口

1. `flake.nix` 中有 `SOLOSISO` 和 `SOLOSISO2` 两个候选；`make iso` 只构建前者。前者使用 GNOME live 环境及 NixOS Calamares 模块，却把 `SolXPS26.config.system.build.toplevel` 放在 ISO 的 `/target-system`。这只是镜像内容，未接入 Calamares 的目标安装作业。
2. 当前 `SolXPS26` 配置导入了固定硬件 UUID、休眠设备、主机名和 `Sol` 用户；`users/Sol/home.nix` 中还有 `/home/sol` 路径。不能直接作为任意目标机器的安装配置。
3. 所用 nixpkgs 锁定在 `02c087f3fe673c9e317f206a627cb6b910336dbe`。其 Calamares `settings.conf` 执行顺序为 `partition → mount → nixos → users → umount`；`nixos` 作业会生成普通 NixOS 配置并运行 `nixos-install`。SolOS 需要对该作业做最小适配，使生成配置和安装命令使用 SolOS flake；不需要重做上游分区界面。
4. `SolOS_Private` 子模块当前无法从本地取得；发行版安装配置不得依赖私有子模块或个人服务。
5. 当前审查没有构建 ISO，也没有实际启动原版 NixOS ISO 或完成一次目标盘安装；“SolOS ISO 可启动”依据用户反馈。原版的运行时界面与行为仍须实测。

### 2.1 原版 Calamares 的已知行为与证据边界

下表来自**锁定版本源码和官方手册**，是静态核对结果，不代表已经在原版 ISO 中操作验证。

| 原版能力 | 已核对的上游行为 | SolOS 需要做的工作 |
|---|---|---|
| 安装页面 | 欢迎、语言/时区、键盘、用户、桌面、非自由软件提示、分区和摘要 | 保留页面；将桌面选项映射为 SolOS profile，调整品牌与必要提示 |
| 分区 | 提供 ext4、Btrfs、XFS、F2FS，配置 LUKS2、EFI 和 swap 选项 | 复用分区和挂载结果；只为 SolOS 声明支持并验证的组合负责 |
| 配置生成 | `nixos` 作业读取用户、语言、时区、固件、分区等选择，调用 `nixos-generate-config` 并生成 `configuration.nix` | 尽量复用这部分逻辑；改为生成 SolOS 的目标 flake 与 profile |
| 系统安装 | `nixos` 作业调用 `nixos-install`，随后 `users` 作业设置密码 | 接入 SolOS 安装目标，保留并实测密码交接顺序 |
| 联网 | 官方手册说明默认安装镜像需要网络 | 离线安装是 SolOS 新增能力，须预置依赖并断网验收 |

由这些源码推断：如果目前的 SolOS ISO 能进入原版 Calamares，继续安装**可能**得到普通 NixOS，而非 `/target-system` 指向的 SolXPS26 系统。这仍需在虚拟机中实际安装确认，不能当作既成事实。

## 3. 技术方案

### 3.1 配置结构

将 flake 拆成三层：

```text
公共 SolOS 模块（系统、网络、图形、主题）
        + 桌面/软件 profile（Niri / KDE / COSMIC）
        + 安装时生成的 machine.nix、user.nix、hardware-configuration.nix
        = nixosConfigurations.installed
```

- 个人机器配置继续使用原有 `hosts/*`，但不能成为安装器默认目标。
- 新建公开、通用的安装 profile；将个人账号、Nextcloud 路径、硬编码显示器及休眠 UUID 排除。
- 桌面映射限定为 `mods/gui/niri`、`mods/gui/kde`、`mods/gui/cosmic` 中的一个。每个选择导入对应的 `launcher.nix` 和所需 Home Manager/overlay 依赖；安装目标不自动导入个人机器使用的三个桌面 specialisation，避免装入未选择的桌面或启用多个 greeter。
- 在目标盘 `/etc/nixos` 写入完整 flake 源码、`flake.lock` 和机器生成文件；打包时不带 `.git`，保证安装时新增文件会被 flake 路径输入识别。
- 目标 flake 是安装与后续更新的唯一主配置。若保留 `configuration.nix`，它只作为指向 flake 的说明或薄入口，避免产生两套会分叉的完整配置。
- `system.stateVersion` 作为安装时确定的固定值保存；后续更新不得随 nixpkgs 升级自动改写。

### 3.2 Calamares 交接

保留上游欢迎、语言、键盘、用户、分区、挂载、卸载界面和作业。基于上游 `calamares-nixos-extensions` 做**最小补丁**：把 `packagechooser` 的桌面列表限定为三个 SolOS 预设，并修改原有 `nixos` 作业的目标配置生成与安装命令。沿用它的硬件生成、分区、加密、进度和错误处理逻辑，不修改 Calamares 本体。若原作业无法小范围补丁，才从锁定版本复制该作业并维护差异。

适配后的 `nixos` 作业顺序：

1. 从 Calamares 的全局存储读取选择，校验目标挂载点、分区、固件类型和输入字符串；在写盘前展示最终摘要。
2. 在目标挂载点运行 `nixos-generate-config`，生成硬件与文件系统配置；按实际分区结果处理 Btrfs 子卷、LUKS、swap 及引导器。
3. 写入 SolOS flake 和机器模块；由 `packagechooser` 的选择映射到 `mods/gui` 中一个固定预设，执行 `nix eval` 检查关键配置，失败时停在可恢复状态并保留日志。
4. 运行 `nixos-install --root <目标> --flake path:<目标>/etc/nixos#installed --no-root-passwd`；对安装日志做进度和错误映射。
5. 保留上游 `users` 作业设置密码的时序。密码不写入 Nix 源码、构建日志或 Nix store；完成后检查目标系统中用户与登录服务一致。

具体 Calamares API、最小补丁范围和密码交接在第一阶段做小型原型确认；若上游 `users` 作业与动态用户名不能正确协作，才补充 SolOS 专用用户适配。这个决策在首次真实安装前定稿。

### 3.3 自动配置生成规则

| 输入/探测 | 生成结果 | 校验重点 |
|---|---|---|
| 分区和挂载点 | `hardware-configuration.nix`、文件系统与 swap | UUID、ESP 挂载点、Btrfs 子卷与加密映射一致 |
| UEFI / BIOS | systemd-boot 或 GRUB 配置 | BIOS/GPT 必须有 BIOS boot 分区；不覆盖错误磁盘 |
| 用户名、全名、主机名 | `user.nix`、`machine.nix` | 合法字符、无重复账号、家目录跟随用户名 |
| 语言、时区、键盘 | locale、time zone、console/XKB | Nix 字符串正确转义，首次登录设置一致 |
| 桌面选项 | 对应 profile 和显示管理器 | 不同时启用相互冲突的 greeter；所选会话可登录 |
| 硬件探测 | 通用固件、必要内核模块 | 不根据单一品牌写死配置；特殊驱动需显式选择 |

配置生成器应可在不写盘的条件下用输入样例检查输出；分区操作本身只由 Calamares 执行。安装日志包含选择、生成文件位置、失败阶段和恢复指令，屏蔽密码等敏感信息。

### 3.4 联网、断网与发布

- 联网：使用锁定的 flake 输入与 Nix substituter；失败时给出可重试的下载或构建错误。
- 断网：ISO 中预置目标 profile 所需 flake 输入和 Nix store 闭包；以**拔掉虚拟网卡**的安装验证作为验收，不能仅凭 ISO 含有 `/target-system` 判定支持离线。
- 公开发布包不引用 `SolOS_Private`，不包含个人账号和服务凭据。ISO 产物附版本、源码提交、构建命令与校验和。
- CI 只执行 Nix 评估、ISO 构建和产物检查；完整安装回归集中在必要的几个虚拟磁盘场景，不建立庞大的自动化 E2E 套件。

## 4. 实施阶段与验收门槛

| 阶段 | 主要产物 | 通过条件 |
|---|---|---|
| A. 原型与方案冻结 | 原版 ISO 行为记录、上游 `nixos` 作业的最小补丁原型、安装数据契约 | 先实际走通原版安装，再用 SolOS ISO 完成一次 UEFI/ext4 安装并首次启动 |
| B. 通用配置 | 公共 profile、生成的 machine/user/hardware 模块 | 任意新用户名和主机名能评估、安装、登录；不引用 XPS UUID |
| C. 存储与引导 | Btrfs、LUKS、手动分区、双系统、BIOS 路径 | 第 5 节矩阵中的关键组合安装后重启可用；保留分区未被改写 |
| D. 离线与桌面 | 离线依赖闭包、三个桌面 profile | 断网可安装；每个桌面至少一次可登录启动 |
| E. 发布 | ISO、校验和、安装/恢复文档、已知限制 | 独立于开发机重建 ISO；按文档可重复安装与排障 |

建议先做阶段 A：它直接验证当前最大的未知数，即在保留上游安装逻辑的同时能否切换为 SolOS flake。阶段 A 不涉及公开发布承诺。

## 5. 最小必要验证矩阵

| 场景 | 固件 / 磁盘 | 文件系统 / 加密 | 网络 | 关键验收 |
|---|---|---|---|---|
| 1 | UEFI / GPT 整盘 | ext4 / 无 | 在线 | 安装、重启、用户登录、后续 `nixos-rebuild` |
| 2 | UEFI / GPT 整盘 | Btrfs / LUKS | 断网 | 密码解锁、子卷挂载、重启、无网络依赖 |
| 3 | UEFI / GPT 手动空闲空间 | ext4 / 无 | 在线 | 既有 ESP 与其他系统仍可用，SolOS 可启动 |
| 4 | BIOS / GPT 整盘 | ext4 / 无 | 在线 | GRUB 安装到选定磁盘并成功启动 |

Niri 为主要桌面验收对象；KDE 和 COSMIC 各做一次安装后的登录检查。关键组合必须经历实际虚拟磁盘安装与重启，因为只做 Nix 评估无法发现分区、引导和密码交接问题。实机验证至少覆盖一台 UEFI 设备；其他硬件若不可得，在发布说明中明确未验证。

## 6. 不同选择的区别项

下表以第 1 节完整方案为基准。金额按 **¥100/小时**折算，均为**不含第 7 节预备金**的粗估；选项共享代码和验证工作，不能直接把各行相加或相减当作报价。

| 决策 | 完整方案中的选择 | 替代选择及实际差别 | 工时差额 | 经费差额 |
|---|---|---|---:|---:|
| 固件 | UEFI + BIOS/GPT | 仅 UEFI：减少上游 BIOS 路径与 SolOS 引导兼容验证 | 减 4～8 小时 | 减 ¥400～800 |
| 文件系统 | ext4 + Btrfs | 仅 ext4：无需核对上游 Btrfs 子卷生成和 SolOS 启动 | 减 6～12 小时 | 减 ¥600～1,200 |
| 加密 | 可选 LUKS | 无加密：无需核对安装时密钥与首次启动解锁 | 减 6～12 小时 | 减 ¥600～1,200 |
| 分区 | 整盘 + 手动空闲空间双系统 | 仅整盘：减少保留分区与双系统引导验证 | 减 8～16 小时 | 减 ¥800～1,600 |
| Windows 分区 | 用户事先预留空闲空间 | 安装器自动缩小现有分区：便捷，但需额外数据安全与恢复验证 | 加 16～30 小时 | 加 ¥1,600～3,000 |
| 安装来源 | 在线 + 断网 | 仅在线：ISO 较小，断网或缓存不可用时无法完成安装 | 减 16～26 小时 | 减 ¥1,600～2,600 |
| 目标桌面 | Niri / KDE / COSMIC 三选一 | 仅 Niri：ISO 与回归矩阵更小 | 减 12～22 小时 | 减 ¥1,200～2,200 |
| Live 桌面 | 延用 GNOME live 安装环境 | 改为 COSMIC 或 Niri live：外观更统一，需额外处理启动、安装器窗口和权限 | 加 8～24 小时 | 加 ¥800～2,400 |
| 架构 | x86_64 | 加 aarch64：增加镜像、构建与硬件验证链 | 加 40～80 小时 | 加 ¥4,000～8,000 |
| 专有驱动 | 通用图形路径，必要固件明确授权 | 自动识别并安装 NVIDIA 等专有驱动：增加显卡、内核和授权选择路径 | 加 12～26 小时 | 加 ¥1,200～2,600 |
| 休眠 | 默认 ZRAM，不生成 `resumeDevice` | 接入上游 swap 选择并适配 SolOS 休眠配置，验证睡眠后恢复 | 加 8～18 小时 | 加 ¥800～1,800 |
| 私有配置 | 发行版不含私有子模块 | 将私有服务放入安装镜像：需仓库授权、密钥和发布边界设计；不建议面向公众 | 单独评估 | 单独评估 |

推荐默认保留完整方案的存储、加密和离线能力；Live 环境先沿用 GNOME，发布版不含私有服务。自动缩小 Windows 分区、aarch64、Live 桌面更换和专有显卡自动识别均作为预算外扩展。若需要缩减本轮经费，可先选择仅 UEFI、仅 Niri 或仅联网安装，并按缩减后的范围重新核算总价。

## 7. 工作量与经费

以下为规划估算，不是外部供应商报价。统一按人民币 **¥100/工程小时**，再加 **15% 预备金**计算。

| 工作包 | 工时 |
|---|---:|
| 原版 ISO 行为核对、技术方案与接口原型 | 12～18 |
| 通用配置和桌面 profile 重构 | 20～32 |
| Calamares 桌面选项和上游安装作业的最小适配 | 20～34 |
| 自动配置生成与输入校验 | 12～22 |
| 上游分区、Btrfs、LUKS、双系统与引导逻辑的 SolOS 适配和验证 | 14～26 |
| 离线 ISO、构建与发布流程 | 18～30 |
| 关键场景验证、修复和用户文档 | 28～46 |
| **合计** | **124～208 小时** |

人工暂估 **¥12,400～20,800**；含 15% 预备金约 **¥14,260～23,920**，建议按 **人民币 1.5 万～2.4 万元**准备。单人顺序实施约 4～7 个自然周，取决于 ISO 构建、安装回归和硬件可用性。阶段 A 可单列约 20～35 小时（¥2,000～3,500，不含预备金），用原版与 SolOS 的实际安装结果校准后续估算；在阶段 A 之前，预算仍属静态分析估算。

已有 Linux/Nix 构建机和测试机器时，软件许可不是主要现金项。新购测试硬件、云构建机、镜像分发带宽及超额存储**不包含**在人工预算中，需在确定发布规模后另算。公开仓库的标准 GitHub Actions runner 运行时间目前免费，但产物存储有额度限制，不能据此假设大型 ISO 的长期托管免费。

## 8. 主要风险与应对

| 风险 | 应对 |
|---|---|
| 上游 Calamares 作业更新导致补丁失效 | 固定 nixpkgs 版本；记录最小差异；更新时先评估和做一条安装回归 |
| 目标 flake 在离线环境缺少输入或 store 闭包 | 单独断网安装验收；构建时生成依赖清单并检查完整性 |
| 手动分区或双系统覆盖既有数据 | 禁止默认自动缩分区；安装前摘要确认；对保留分区做前后 UUID/文件检查 |
| 用户密码、加密密钥进入日志或 Nix store | 密码由安装器作业直接写入目标系统；日志脱敏；禁止生成明文/哈希密码配置文件 |
| 不同桌面 greeter 和 Home Manager 模块冲突 | 每个 profile 单独评估和登录检查；公共模块不绑定个人账号 |
| 私有子模块阻断公开构建 | 安装目标和发行版构建与 `SolOS_Private` 隔离 |

## 9. 依据

- 本仓库：`flake.nix`、`Makefile`、`users/Sol/*`、`hosts/SolXPS26/*`、`flake.lock`（提交 `a0f3906`）。
- [锁定版本的 Calamares 配置及执行顺序](https://github.com/NixOS/nixpkgs/blob/02c087f3fe673c9e317f206a627cb6b910336dbe/pkgs/by-name/ca/calamares-nixos-extensions/src/config/settings.conf)。
- [锁定版本的桌面选择配置](https://raw.githubusercontent.com/NixOS/nixpkgs/02c087f3fe673c9e317f206a627cb6b910336dbe/pkgs/by-name/ca/calamares-nixos-extensions/src/config/modules/packagechooser.conf)和[分区配置](https://raw.githubusercontent.com/NixOS/nixpkgs/02c087f3fe673c9e317f206a627cb6b910336dbe/pkgs/by-name/ca/calamares-nixos-extensions/src/config/modules/partition.conf)。
- [锁定版本的 NixOS 安装作业](https://github.com/NixOS/nixpkgs/blob/02c087f3fe673c9e317f206a627cb6b910336dbe/pkgs/by-name/ca/calamares-nixos-extensions/src/modules/nixos/main.py)。
- [NixOS 手册：图形安装、生成硬件配置、flake 安装和引导](https://nixos.org/manual/nixos/stable/)；[官方 Wiki：默认 ISO 需要联网](https://wiki.nixos.org/wiki/FAQ)。
- [GitHub Actions 计费说明](https://docs.github.com/en/billing/concepts/product-billing/github-actions)。

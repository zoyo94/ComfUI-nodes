# ComfyUI 自定义节点归档

本仓库通过 git submodule 归档了 38 个常用的 ComfyUI 自定义节点，全部使用 `--depth 1` 浅克隆以减小体积。

## 用法

### 初次克隆本仓库（同时拉取所有子模块）

```bash
git clone --recurse-submodules <本仓库地址>
```

如果已经克隆但没拉子模块：

```bash
git submodule update --init --recursive --depth 1
```

### 一键更新所有节点到各自远端最新版本

```bash
git submodule update --remote --merge
```

更新完成后，把指针变化提交进父仓库：

```bash
git add .
git commit -m "update submodules"
```

### 单独更新某个节点

```bash
git -C ComfyUI-Manager pull
```

### 增删节点

添加：

```bash
git submodule add -f --depth 1 <repo-url> <local-name>
```

删除：

```bash
git submodule deinit -f <local-name>
git rm -f <local-name>
rm -rf .git/modules/<local-name>
```

## 节点清单

| 名称 | 来源 |
|---|---|
| AIGODLIKE-COMFYUI-TRANSLATION | https://github.com/AIGODLIKE/AIGODLIKE-COMFYUI-TRANSLATION |
| a-person-mask-generator | https://github.com/djbielejeski/a-person-mask-generator |
| ComfyUI_Comfyroll_CustomNodes | https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes |
| ComfyUI_essentials | https://github.com/cubiq/ComfyUI_essentials |
| ComfyUI_FizzNodes | https://github.com/FizzleDorf/ComfyUI_FizzNodes |
| ComfyUI_IPAdapter_plus | https://github.com/cubiq/ComfyUI_IPAdapter_plus |
| ComfyUI_Mexx_Styler | https://github.com/SoftMeng/ComfyUI_Mexx_Styler |
| ComfyUI_UltimateSDUpscale | https://github.com/ssitu/ComfyUI_UltimateSDUpscale |
| ComfyUI-Advanced-ControlNet | https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet |
| ComfyUI-AnimateDiff-Evolved | https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved |
| ComfyUI-CogVideoXWrapper | https://github.com/kijai/ComfyUI-CogVideoXWrapper |
| ComfyUI-Custom-Scripts | https://github.com/pythongosssss/ComfyUI-Custom-Scripts |
| ComfyUI-DD-Nodes | https://github.com/Dontdrunk/ComfyUI-DD-Nodes |
| ComfyUI-DepthAnythingV3 | https://github.com/PozzettiAndrea/ComfyUI-DepthAnythingV3 |
| ComfyUI-Easy-Use | https://github.com/yolain/ComfyUI-Easy-Use |
| ComfyUI-Fluxtapoz | https://github.com/logtd/ComfyUI-Fluxtapoz |
| ComfyUI-Frame-Interpolation | https://github.com/Fannovel16/ComfyUI-Frame-Interpolation |
| ComfyUI-GeometryPack | https://github.com/PozzettiAndrea/ComfyUI-GeometryPack |
| ComfyUI-GGUF | https://github.com/city96/ComfyUI-GGUF |
| ComfyUI-IC-Light | https://github.com/kijai/ComfyUI-IC-Light |
| ComfyUI-Impact-Pack | https://github.com/ltdrdata/ComfyUI-Impact-Pack |
| ComfyUI-Impact-Subpack | https://github.com/ltdrdata/ComfyUI-Impact-Subpack |
| ComfyUI-Inspire-Pack | https://github.com/ltdrdata/ComfyUI-Inspire-Pack |
| ComfyUI-IPAdapter-Flux | https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux |
| ComfyUI-KJNodes | https://github.com/kijai/ComfyUI-KJNodes |
| ComfyUI-Manager | https://github.com/ltdrdata/ComfyUI-Manager |
| ComfyUI-SAM2 | https://github.com/neverbiasu/ComfyUI-SAM2 |
| ComfyUI-tbox | https://github.com/ai-shizuka/ComfyUI-tbox |
| ComfyUI-TCD | https://github.com/JettHu/ComfyUI-TCD |
| ComfyUI-ToSVG | https://github.com/Yanick112/ComfyUI-ToSVG |
| comfyui-umeairt-toolkit | https://gitlab.com/UmeAiRT-Studio/comfyui-umeairt-toolkit |
| comfyui-various | https://github.com/jamesWalker55/comfyui-various |
| ComfyUI-VideoHelperSuite | https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite |
| efficiency-nodes-comfyui | https://github.com/jags111/efficiency-nodes-comfyui |
| image-resize-comfyui | https://github.com/brunokk/image-resize-comfyui |
| Image-Vector-for-ComfyUI | https://github.com/AARG-FAN/Image-Vector-for-ComfyUI |
| rgthree-comfy | https://github.com/rgthree/rgthree-comfy |
| was-node-suite-comfyui | https://github.com/ltdrdata/was-node-suite-comfyui |

## 几点说明

- `comfyui-umeairt-toolkit` 来源是 GitLab（原 GitHub 仓库已下线），git submodule 同样支持。
- `image-resize-comfyui` 原作者 `palant/...` 仓库已删除，本归档采用 GitHub 上仍可访问的 `brunokk/image-resize-comfyui`。
- `was-node-suite-comfyui` 使用 ComfyUI-Manager 作者 `ltdrdata` 维护的 Revised fork（原作者 WASasquatch 的版本相对停滞）。

## 辅助脚本

- `add_submodules.sh`：首次批量添加全部 38 个子模块。
- `retry_submodules.sh`：对网络瞬时失败的子模块自动重试最多 4 轮。

如果将来 git clone/pull 出现 SSL/网络瞬断错误，可直接重跑 `retry_submodules.sh`。

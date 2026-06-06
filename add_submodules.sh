#!/usr/bin/env bash
# Sequentially add each ComfyUI custom node repo as a shallow submodule.
# Tolerates individual failures so a single bad URL doesn't abort the batch.
set -u
cd "$(dirname "$0")" || exit 1

REPOS=(
  "AIGODLIKE-COMFYUI-TRANSLATION|https://github.com/AIGODLIKE/AIGODLIKE-COMFYUI-TRANSLATION.git"
  "a-person-mask-generator|https://github.com/djbielejeski/a-person-mask-generator.git"
  "ComfyUI_Comfyroll_CustomNodes|https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git"
  "ComfyUI_essentials|https://github.com/cubiq/ComfyUI_essentials.git"
  "ComfyUI_FizzNodes|https://github.com/FizzleDorf/ComfyUI_FizzNodes.git"
  "ComfyUI_IPAdapter_plus|https://github.com/cubiq/ComfyUI_IPAdapter_plus.git"
  "ComfyUI_Mexx_Styler|https://github.com/SoftMeng/ComfyUI_Mexx_Styler.git"
  "ComfyUI_UltimateSDUpscale|https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git"
  "ComfyUI-Advanced-ControlNet|https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git"
  "ComfyUI-AnimateDiff-Evolved|https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git"
  "ComfyUI-CogVideoXWrapper|https://github.com/kijai/ComfyUI-CogVideoXWrapper.git"
  "ComfyUI-Custom-Scripts|https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git"
  "ComfyUI-DD-Nodes|https://github.com/Dontdrunk/ComfyUI-DD-Nodes.git"
  "ComfyUI-DepthAnythingV3|https://github.com/PozzettiAndrea/ComfyUI-DepthAnythingV3.git"
  "ComfyUI-Easy-Use|https://github.com/yolain/ComfyUI-Easy-Use.git"
  "ComfyUI-Fluxtapoz|https://github.com/logtd/ComfyUI-Fluxtapoz.git"
  "ComfyUI-Frame-Interpolation|https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git"
  "ComfyUI-GeometryPack|https://github.com/PozzettiAndrea/ComfyUI-GeometryPack.git"
  "ComfyUI-GGUF|https://github.com/city96/ComfyUI-GGUF.git"
  "ComfyUI-IC-Light|https://github.com/kijai/ComfyUI-IC-Light.git"
  "ComfyUI-Impact-Pack|https://github.com/ltdrdata/ComfyUI-Impact-Pack.git"
  "ComfyUI-Impact-Subpack|https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git"
  "ComfyUI-Inspire-Pack|https://github.com/ltdrdata/ComfyUI-Inspire-Pack.git"
  "ComfyUI-IPAdapter-Flux|https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux.git"
  "ComfyUI-KJNodes|https://github.com/kijai/ComfyUI-KJNodes.git"
  "ComfyUI-Manager|https://github.com/ltdrdata/ComfyUI-Manager.git"
  "ComfyUI-SAM2|https://github.com/neverbiasu/ComfyUI-SAM2.git"
  "ComfyUI-tbox|https://github.com/ai-shizuka/ComfyUI-tbox.git"
  "ComfyUI-TCD|https://github.com/JettHu/ComfyUI-TCD.git"
  "ComfyUI-ToSVG|https://github.com/Yanick112/ComfyUI-ToSVG.git"
  "comfyui-umeairt-toolkit|https://gitlab.com/UmeAiRT-Studio/comfyui-umeairt-toolkit.git"
  "comfyui-various|https://github.com/jamesWalker55/comfyui-various.git"
  "ComfyUI-VideoHelperSuite|https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git"
  "efficiency-nodes-comfyui|https://github.com/jags111/efficiency-nodes-comfyui.git"
  "image-resize-comfyui|https://github.com/brunokk/image-resize-comfyui.git"
  "Image-Vector-for-ComfyUI|https://github.com/AARG-FAN/Image-Vector-for-ComfyUI.git"
  "rgthree-comfy|https://github.com/rgthree/rgthree-comfy.git"
  "was-node-suite-comfyui|https://github.com/ltdrdata/was-node-suite-comfyui.git"
)

ok=0
fail=0
fail_list=()
total=${#REPOS[@]}
i=0
for entry in "${REPOS[@]}"; do
  i=$((i+1))
  name="${entry%%|*}"
  url="${entry##*|}"
  if [ -d "$name" ]; then
    echo "[$i/$total] SKIP $name (already exists)"
    continue
  fi
  echo "[$i/$total] ADD  $name  <-  $url"
  if git submodule add -f --depth 1 "$url" "$name" >/dev/null 2>&1; then
    ok=$((ok+1))
    echo "[$i/$total] OK   $name"
  else
    fail=$((fail+1))
    fail_list+=("$name|$url")
    echo "[$i/$total] FAIL $name"
  fi
done

echo ""
echo "=== DONE: ok=$ok fail=$fail / total=$total ==="
if [ "$fail" -gt 0 ]; then
  echo "Failed:"
  for f in "${fail_list[@]}"; do
    echo "  $f"
  done
fi

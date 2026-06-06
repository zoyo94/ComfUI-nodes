#!/usr/bin/env bash
# Retry adding any submodule entries that don't yet have a directory.
# Loops up to MAX_ATTEMPTS, sleeping between, with tolerant HTTP timeouts.
set -u
cd "$(dirname "$0")" || exit 1

# Per-command git http settings: tolerate slow connections without disconnecting.
export GIT_HTTP_LOW_SPEED_LIMIT=1000
export GIT_HTTP_LOW_SPEED_TIME=120

REPOS=(
  "a-person-mask-generator|https://github.com/djbielejeski/a-person-mask-generator.git"
  "ComfyUI_Comfyroll_CustomNodes|https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git"
  "ComfyUI-Advanced-ControlNet|https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git"
  "ComfyUI-Frame-Interpolation|https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git"
  "ComfyUI-IC-Light|https://github.com/kijai/ComfyUI-IC-Light.git"
  "ComfyUI-Manager|https://github.com/ltdrdata/ComfyUI-Manager.git"
  "ComfyUI-SAM2|https://github.com/neverbiasu/ComfyUI-SAM2.git"
  "comfyui-various|https://github.com/jamesWalker55/comfyui-various.git"
  "ComfyUI-VideoHelperSuite|https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git"
  "efficiency-nodes-comfyui|https://github.com/jags111/efficiency-nodes-comfyui.git"
  "Image-Vector-for-ComfyUI|https://github.com/AARG-FAN/Image-Vector-for-ComfyUI.git"
  "was-node-suite-comfyui|https://github.com/ltdrdata/was-node-suite-comfyui.git"
)

MAX_ATTEMPTS=4

for attempt in $(seq 1 $MAX_ATTEMPTS); do
  remaining=0
  echo "=== Attempt $attempt/$MAX_ATTEMPTS ==="
  for entry in "${REPOS[@]}"; do
    name="${entry%%|*}"
    url="${entry##*|}"
    if [ -d "$name" ]; then
      continue
    fi
    remaining=$((remaining+1))
    echo "  ADD  $name"
    if git submodule add -f --depth 1 "$url" "$name" >/dev/null 2>&1; then
      echo "  OK   $name"
    else
      echo "  FAIL $name"
    fi
  done
  if [ "$remaining" -eq 0 ]; then
    echo "=== ALL DONE (no remaining at attempt $attempt) ==="
    break
  fi
  echo "=== End attempt $attempt; remaining=$remaining ==="
  if [ "$attempt" -lt "$MAX_ATTEMPTS" ]; then
    sleep 5
  fi
done

# Final status
remaining=0
missing=()
for entry in "${REPOS[@]}"; do
  name="${entry%%|*}"
  if [ ! -d "$name" ]; then
    remaining=$((remaining+1))
    missing+=("$name")
  fi
done

if [ "$remaining" -eq 0 ]; then
  echo "=== SUCCESS: all 12 retries cloned ==="
else
  echo "=== STILL FAILING ($remaining): ==="
  for m in "${missing[@]}"; do
    echo "  $m"
  done
fi

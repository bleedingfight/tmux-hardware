#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_gpu_name() {

  if command_exists "nvidia-smi"; then
    loads=$(cached_eval nvidia-smi)
  elif command_exists "cuda-smi"; then
    loads=$(cached_eval cuda-smi)
  else
    echo "No GPU"
    return
  fi
  gpu_name=$(echo "$loads" | nvidia-smi | grep -Eo "NVIDIA\s+\w+\s+\w+\s[0-9]+")
  gpu_nums=$(nvidia-smi --query-gpu=count --format=csv,noheader)
  if [ ${gpu_nums} -eq 1 ]; then
    echo ${gpu_name}
  else
    echo "${gpu_name}${gpu_nums}"
  fi
}

main() {
  print_gpu_name
}
main "$@"

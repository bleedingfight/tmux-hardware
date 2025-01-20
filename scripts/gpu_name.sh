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
  gpu_name=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader | sort | uniq)
  gpu_nums=$(nvidia-smi --query-gpu=count --format=csv,noheader | sort | uniq)
  if [ "${gpu_nums}" -eq 1 ]; then
    echo "${gpu_name}"
  else
    echo "${gpu_name}${gpu_nums}"
  fi
}

main() {
  print_gpu_name
}
main "$@"


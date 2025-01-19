#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_host_ip() {
  # 判断系统类型
  if [[ "$(uname)" == "Linux" ]]; then
    host_ip=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -n 1)
  elif [[ "$(uname)" == "Darwin" ]]; then
    host_ip=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)
  else
    echo "Unsupported operating system"
  fi
  echo ${host_ip}
}

main() {
  print_host_ip
}
main "$@"

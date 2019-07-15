#!/bin/bash

syntax() {
  echo "syntax: $0 <config_item>"
  exit 1
}

print_config() {
  cd "$(dirname "${BASH_SOURCE[0]}")" || exit

  x="$(grep ^"$1" ./remote_state.config)"
  if [ "$x" ]; then
  	echo "$x" | cut -d'=' -f2
  else
  	syntax
  fi
}

if [ "$1" ]; then
  print_config "$1"
else
  syntax
fi

#!/bin/sh

NUSHELL_CONFIG=~/.config/nushell/config.nu

sed -i 's|show_banner: true|show_banner: false|g' "$NUSHELL_CONFIG"

if ! grep -q "alias ll =" "$NUSHELL_CONFIG"; then
  echo -e "\nalias ll = ls -al" >> "$NUSHELL_CONFIG"
fi

if ! grep -q "alias pm =" "$NUSHELL_CONFIG"; then
  echo -e "\nalias pm = pnpm" >> "$NUSHELL_CONFIG"
fi
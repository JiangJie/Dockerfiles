#!/bin/sh

NUSHELL_CONFIG=~/.config/nushell/config.nu

if ! grep -q "\$env.config.show_banner = false" "$NUSHELL_CONFIG"; then
  echo -e "\n\$env.config.show_banner = false" >> "$NUSHELL_CONFIG"
fi

if ! grep -q "alias ll =" "$NUSHELL_CONFIG"; then
  echo -e "\nalias ll = ls -al" >> "$NUSHELL_CONFIG"
fi

if ! grep -q "alias pm =" "$NUSHELL_CONFIG"; then
  echo -e "\nalias pm = pnpm" >> "$NUSHELL_CONFIG"
fi
#!/usr/bin/env bash

echo "Installing additional omarchy themes..."

# Download additional themes
# For more inspiration see: https://learn.omacom.io/2/the-omarchy-manual/90/extra-themes
omarchy-theme-install https://github.com/vale-c/omarchy-arc-blueberry
omarchy-theme-install https://github.com/motorsss/omarchy-solarizedosaka-theme

# Enable theme Matte Black
omarchy-theme-set matte-black

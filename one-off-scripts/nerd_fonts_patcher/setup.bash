#!/usr/bin/env bash

# Instructions and script from: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-8-patch-your-own-font

# Helper function: check if a command is available in PATH
function exists() {
  command -v "$1" >/dev/null 2>&1
}

# Always download and use the latest version, every time it's ran
curl --silent --location --output FontPatcher.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
unzip -o FontPatcher.zip -d ./FontPatcher

# Give the script execute permissions
if [ ! -x "./FontPatcher/font-patcher" ]; then
  chmod +x ./FontPatcher/font-patcher
fi

if [ ! -d "./.venv" ]; then
  python -m venv .venv
  source .venv/bin/activate
  pip install --upgrade pip
fi

# Install fontforge (a required CLI tool) with Homebrew if not installed
if ! exists fontforge; then
  brew install fontforge
fi
# It's also stated that this "Requires: Fontforge, Python 3, python-fontforge and argparse packages"

# If Exported exists and is not empty, exit. If it doesn't exist, create it.
if [ -d "Exported" ]; then
  if [ -n "$(ls -A Exported)" ]; then
    echo "The 'Exported' directory is not empty."
    exit 1
  fi
else
  mkdir Exported
fi

# Create the directory for unpatched fonts
if [ ! -d "Original" ]; then
  mkdir Original
fi

read -r -s -n 1 -p "Move the unpatched fonts to the 'Original' directory and press any key to continue..."

# Additional options:
# -s, --mono, --use-single-width-glyphs Whether to generate the glyphs as single-width not double-width (default is double-width) (Nerd Font Mono)
# --variable-width-glyphs Do not adjust advance width (no "overhang") (Nerd Font Propo)
# -l, --adjust-line-height Whether to adjust line heights (attempt to center powerline separators more evenly)

# Patch every font variant (file)
for entry in "./Original"/*
do
  fontforge -script ./FontPatcher/font-patcher --complete --careful --outputdir ./Exported "$entry"
done

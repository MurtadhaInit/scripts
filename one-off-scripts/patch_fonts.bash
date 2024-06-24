#!/usr/bin/env bash
# To patch any font

# helper function
function exists() {
  command -v "$1" >/dev/null 2>&1
}

read -p "Make sure you have enough storage. Continue? " -n 1 -r
echo
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

  mkdir NerdFonts 
  cd NerdFonts

  # clone the repo
  if [ ! -d "./nerd-fonts" ]; then
    git clone git@github.com:ryanoasis/nerd-fonts.git
  fi

  # install fontforge if it doesn't exist
  if ! exists fontforge; then
    brew install fontforge
  fi

  # give the script execute permissions
  if [ ! -x "./nerd-fonts/font-patcher" ]; then
    chmod +x ./nerd-fonts/font-patcher
  fi

  # create the necessary directories
  if [ ! -d "fonts" ]; then
    mkdir fonts
  fi
  if [ ! -d "patched-fonts" ]; then
    mkdir patched-fonts
  fi
  if [ ! -d "patched-fonts-windows" ]; then
    mkdir patched-fonts-windows
  fi

  # this is where unpatched fonts are placed
  search_dir=./fonts

  # check the provided fonts directory exists
  if [ -z "$search_dir" ]; then echo "No 'fonts' directory"; exit 1; fi
  
  read -n 1 -s -r -p "Place unpatched fonts in the 'fonts' directory then press any key to continue..."
  echo

  # execute the script for every font in that directory
  for entry in "$search_dir"/*
  do
    # the --also-windows option is has apparently been deprecated
    # fontforge -script ./nerd-fonts/font-patcher "$entry" --complete --careful --outputdir ./patched-fonts

    fontforge -script font-patcher --adjust-line-height --complete --careful --outputdir ./patched-fonts --variable-width-glyphs --progressbars "$entry"

  done

  # move patched windows fonts elsewhere
  mv -f ./patched-fonts/*Windows* ./patched-fonts-windows/
  # copy patched fonts to the fonts directory for the current user
  cp -iR ./patched-fonts/ ~/Library/Fonts/

fi

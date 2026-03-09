#!/usr/bin/env bash
set -e

if [ -d ${HOME}/.local/share/fonts ]
then
  echo "HackGen is already installed"
else
  # 最新版の HackGen リリースページ
  RELEASE_URL="https://api.github.com/repos/yuru7/HackGen/releases/latest"
  
  echo "Fetching latest HackGen release info..."
  
  # 最新版の zip URL を取得
  ZIP_URL=$(curl -s "$RELEASE_URL" | grep browser_download_url | grep "HackGen_NF" | grep "zip" | cut -d '"' -f 4)
  
  if [[ -z "$ZIP_URL" ]]; then
      echo "Failed to fetch download URL."
      exit 1
  fi
  
  echo "Download URL: $ZIP_URL"
  
  # 作業ディレクトリ
  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"
  
  echo "Downloading HackGen..."
  curl -LO "$ZIP_URL"
  
  ZIP_FILE=$(basename "$ZIP_URL")
  
  echo "Unzipping..."
  unzip -q "$ZIP_FILE"
  
  # フォントインストール先
  FONT_DIR="$HOME/.local/share/fonts/HackGen"
  mkdir -p "$FONT_DIR"
  
  echo "Installing fonts to $FONT_DIR"
  find . -type f -name "*.ttf" -exec cp {} "$FONT_DIR" \;
  
  echo "Updating font cache..."
  fc-cache -fv > /dev/null
  
  echo "HackGen installation completed successfully."
  
  gsettings set org.gnome.desktop.interface font-name 'HackGen 11'
  gsettings set org.gnome.desktop.interface monospace-font-name 'HackGen 11'
fi
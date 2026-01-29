#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
sudo apt update
APT_PKGS=(
"flatpak"       "snapd" "ibus-mozc"     "mozc-data"                "mozc-server"           "mozc-utils-gui"       "git-flow"         "libimage-exiftool-perl" "yadm "
"g810-led"      "microsoft-edge-stable" "1password"                "1password-cli"         "google-chrome-stable" "code"             "virtualbox-7.0"         "docker-ce"
"docker-ce-cli" "containerd.io"         "docker-buildx-plugin"     "docker-compose-plugin" "libfuse3-3"           "krita"            "obs-studio"             "darktable"
"inkscape"      "gimp"                  "ubuntu-restricted-extras" "ffmpeg"                "imagemagick"          "gparted"          "fcitx5-mozc"            "gnome-disk-utility"
"popsicle-gtk"  "figlet"                "git"                      "flatpak"               "snapd"                "appimagelauncher" "build-essential"        "curl"
"libssl-dev" "zlib1g-dev" "libbz2-dev" "libreadline-dev" "libsqlite3-dev" "wget" "llvm" "libncursesw5-dev" "xz-utils" "tk-dev" "libxml2-dev" "libxmlsec1-dev" "libffi-devliblzma-dev" )

for i in "${APT_PKGS[@]}"
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    echo -n "installing $i ... "
    sudo apt install -y ${i}  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      show_success_message
    else
      show_error_message
      exit 9
    fi
  else
    echo "$i is already installed"
  fi
done

exit 1
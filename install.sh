# This is a personal Fedora installation script for many
# needed software so it wouldn't be as hard to track and install everything else

# ================================================ Programs needed =====================================================

LIST_OF_APPS="blender gimp stacer steam bashtop htop kdenlive krita eclipse lutris audacity xonotic nodejs inkscapo docker-ce docker-ce-cli containerd.io docker-compose winehq-stable gcc-c++ make"

# ================================================ Software and Eviroments =====================================================
DOCKER_SETUP="dnf-plugins-core"
DOCKER_ADD_REPO=" tee /etc/yum.repos.d/docker-ce.repo<<EOF
                    [docker-ce-stable]
                    name=Docker CE Stable - \$basearch
                    baseurl=https://download.docker.com/linux/fedora/31/\$basearch/stable
                    enabled=1
                    gpgcheck=1
                    gpgkey=https://download.docker.com/linux/fedora/gpg
                    EOF"

WINE_SETUP="config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/32/winehq.repo"

# ================================================ Flatpak Apps =====================================================

SLACK="flatpak install flathub com.slack.Slack"
SKYPE="flatpak install flathub com.skype.Client"
ZOOM="flatpak install flathub us.zoom.Zoom"
WAPP="flatpak install flathub io.bit3.WhatsAppQT"
VS_CODE="flatpak install flathub com.visualstudio.code"
DISCORD="flatpak install flathub com.discordapp.Discord"

# ================================================ Commdans =====================================================

# dnf makecache
# sudo systemctl enable --now docker
# sudo usermod -aG docker $(whoami)
# newgrp docker
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

function InstEssent() {

  dnf -y update
  curl https://rpm.nodesource.com/setup_14.x | sudo -E bash -
  dnf makecache && dnf "$WINE_SETUP" && sudo "$DOCKER_ADD_REPO" && dnf install $DOCKER_SETUP && dnf install "$LIST_OF_APPS"
  systemctl enable --now docker
  sudo usermod -aG docker $(whoami)
  newgrp docker
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  $SLACK
  $SKYPE
  $ZOOM
  $WAPP
  $VS_CODE
  $DISCORD

  sleep 1
}

printf "%s" "${installOf}"

InstEssent &
pid_InstEssent="$!"

while kill -0 "$pid" 2>/dev/null; do
  printProgressBar
  sleep 1
done

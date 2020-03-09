#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_LIBRATBAG="ppa:libratbag-piper/piper-libratbag-git"
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.20.40428-bionic_amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

DIRETORIO_ANDROID="~/Android/"
DIRETORIO_ANDROID_SDK="$DIRETORIO_ANDROID/Sdk"

PROGRAMAS_PARA_INSTALAR=(
  snapd
  virtualbox
  inkscape
  node
  git
  plank

  
  

)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##
sudo apt update -y

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"


## Baixando GITHUB Cli 

echo 'import requests' >> ~/Downloads/temp2.py
echo 'import os' >> ~/Downloads/temp2.py
echo 'DIR = "~/Downloads/programas"' >> ~/Downloads/temp2.py
echo 'Version = requests.get("https://github.com//cli/cli/releases/latest/").text.split("releases/tag/")[1].split("&")[0].strip()' >> ~/Downloads/temp2.py
echo '' >> ~/Downloads/temp2.py
echo 'Link = "https://github.com/cli/cli/releases/download/" +Version+ "/gh_"+ Version[1:]+"_linux_amd64.deb"' >> ~/Downloads/temp2.py
echo '' >> ~/Downloads/temp2.py
echo 'out = Link' >> ~/Downloads/temp2.py
echo 'os.system("wget -c " + out + " -P " + DIR)' >> ~/Downloads/temp2.py

python3 ~/Downloads/temp2.py

rm ~/Downloads/temp2.py



##


## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y


## instalando Android studio
mkdir $DIRETORIO_ANDROID
mkdir $DIRETORIO_ANDROID_SDK
echo 'import requests' >> ~/Downloads/temp.py
echo 'import os' >> ~/Downloads/temp.py
echo "DIR = '$DIRETORIO_ANDROID_SDK'" >> ~/Downloads/temp.py
echo 'Link = requests.get("https://developer.android.com/studio/index.html#downloads").text.split("Linux:")[-1].split()[1].split("https")[-1][:-1]' >> ~/Downloads/temp.py
echo 'out = str("https"+Link)' >> ~/Downloads/temp.py
echo 'os.system("wget -c " + out + " -P " + DIR)' >> ~/Downloads/temp.py

python3 ~/Downloads/temp.py

rm ~/Downloads/temp.py

tar -xvf ~/Downloads/android-studio-ide-192.6241897-linux.tar.gz

mv ./android-studio ~/Android/Sdk

sudo echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
sudo echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.bashrc
sudo echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.bashrc
sudo echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.bashrc
sudo echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc


## Instalando pacotes Flatpak ##
flatpak install flathub com.obsproject.Studio -y

## Instalando pacotes Snap ##
sudo snap install photogimp
# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

sudo echo "git_branch() {" >> ~/.bashrc
sudo echo "git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'" >> ~/.bashrc
sudo echo "}" >> ~/.bashrc

sudo echo 'export PS1="\[\e[32m\]\u \[\033[01;32m\] \W \[\e[91m\]\$(git_branch)\[\033[00m\]\$ "'>> ~/.bashrc

sudo apt-get install python3-venv

$DIRETORIO_ANDROID_SDK/android-studio/bin/studio.sh


 

#!/bin/bash

# Colores
RED='\033[0;31m'
ORANGE='\033[0;33m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${ORANGE}"
echo "██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗██████╗ "
echo "██╔══██╗██║     ██║   ██║██╔═══██╗██║████╗  ██║██╔══██╗"
echo "██████╔╝██║     ██║   ██║██║   ██║██║██╔██╗ ██║██║  ██║"
echo "██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║██║  ██║"
echo "██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║██████╔╝"
echo "╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ "
echo -e "${WHITE}        Canal de YouTube: ${RED}@PlugInPower"
echo -e "${NC}"

if [ -z "$1" ]; then
  echo -e "${RED}Uso:${NC} ./install_java.sh <8 | 11 | 17 | 21>"
  exit 1
fi

VERSION="$1"
ARCH=$(dpkg --print-architecture)

BASE_URL="https://api.adoptium.net/v3/binary/latest/${VERSION}/ga/linux/${ARCH}/jdk/hotspot/normal/eclipse"

show_loading() {
  chars="/—\\|"
  for ((i=0; i<15; i++)); do
    for ((j=0; j<${#chars}; j++)); do
      echo -ne "\r${ORANGE}Instalando${NC} ${chars:$j:1}"
      sleep 0.1
    done
  done
  echo -ne "\r"
}

sudo apt update -y > /dev/null 2>&1
sudo apt install -y wget tar > /dev/null 2>&1

mkdir -p /opt/java

echo -e "${WHITE}Descargando Java $VERSION desde Adoptium...${NC}"
wget -q --show-progress -O java.tar.gz "$BASE_URL"

echo -e "${WHITE}Extrayendo Java...${NC}"
tar -xzf java.tar.gz -C /opt/java
rm java.tar.gz

JAVA_FOLDER=$(find /opt/java -maxdepth 1 -type d -name "jdk-${VERSION}*" | head -n 1)

sudo update-alternatives --install /usr/bin/java java "$JAVA_FOLDER/bin/java" 1
sudo update-alternatives --install /usr/bin/javac javac "$JAVA_FOLDER/bin/javac" 1
sudo update-alternatives --set java "$JAVA_FOLDER/bin/java"
sudo update-alternatives --set javac "$JAVA_FOLDER/bin/javac"

show_loading

# Confirmación
echo -e "\n${WHITE}✔ Java $VERSION instalado correctamente.${NC}"
java -version


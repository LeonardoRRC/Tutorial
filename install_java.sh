#!/bin/bash

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

echo -e "${WHITE}Actualizando paquetes...${NC}"
apt update -y > /dev/null 2>&1
apt install -y wget tar curl > /dev/null 2>&1

echo -e "${WHITE}Instalando Java $VERSION...${NC}"

mkdir -p /opt/java
cd /opt/java || exit 1

DOWNLOAD_URL=$(curl -s "https://api.adoptium.net/v3/assets/latest/$VERSION/ga?architecture=$ARCH&heap_size=normal&image_type=jdk&jvm_impl=hotspot&os=linux&vendor=eclipse" \
| grep 'browser_download_url' | grep 'tar.gz' | cut -d '"' -f 4 | head -n 1)

if [ -z "$DOWNLOAD_URL" ]; then
  echo -e "${RED}❌ No se pudo obtener el enlace de descarga para Java $VERSION.${NC}"
  exit 1
fi

wget -q --show-progress -O java.tar.gz "$DOWNLOAD_URL"
tar -xzf java.tar.gz
rm java.tar.gz

JAVA_FOLDER=$(find . -maxdepth 1 -type d -name "jdk*" | head -n 1)

update-alternatives --install /usr/bin/java java "/opt/java/$JAVA_FOLDER/bin/java" 1
update-alternatives --install /usr/bin/javac javac "/opt/java/$JAVA_FOLDER/bin/javac" 1
update-alternatives --set java "/opt/java/$JAVA_FOLDER/bin/java"
update-alternatives --set javac "/opt/java/$JAVA_FOLDER/bin/javac"

echo -e "\n${WHITE}✔ Java $VERSION instalado correctamente.${NC}"
java -version

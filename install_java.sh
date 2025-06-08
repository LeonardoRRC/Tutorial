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

echo -e "${WHITE}Actualizando paquetes...${NC}"
apt update -y > /dev/null 2>&1

echo -e "${WHITE}Instalando Java $VERSION...${NC}"

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

case "$VERSION" in
  8)
    apt install openjdk-8-jre-headless > /dev/null 2>&1 &
    show_loading
    ;;
  11)
    apt install openjdk-11-jre-headless > /dev/null 2>&1 &
    show_loading
    ;;
  17)
    apt install openjdk-17-jre-headless > /dev/null 2>&1 &
    show_loading
    ;;
  21)
    apt install openjdk-21-jre-headless > /dev/null 2>&1 &
    show_loading
    ;;
  *)
    echo -e "${RED}Versión no soportada. Usa 8, 11, 17 o 21.${NC}"
    exit 1
    ;;
esac

echo -e "\n${WHITE}✔ Java $VERSION instalado correctamente.${NC}"
java -version

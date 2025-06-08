#!/bin/bash

RED='\033[0;31m'
WHITE='\033[1;37m'
NC='\033[0m'

if [ -z "$1" ]; then
  echo -e "${RED}Uso:${NC} ./install_oracle_java.sh <8 | 11 | 17 | 21>"
  exit 1
fi

VERSION="$1"
INSTALL_DIR="/opt/java"
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR || exit 1

case $VERSION in
  8)
    JDK_VERSION="8u202"
    JDK_BUILD="b08"
    JDK_HASH="1961070e4c9b4e26a04e7f5a083f551e"
    FOLDER_NAME="jdk1.8.0_202"
    ;;
  11)
    JDK_VERSION="11.0.2"
    JDK_BUILD="9"
    JDK_HASH="7b1d2d4b48a14584b3c5d55d930d5c7e"
    FOLDER_NAME="jdk-11.0.2"
    ;;
  17)
    JDK_VERSION="17.0.2"
    JDK_BUILD="8"
    JDK_HASH="d7d0f581cf5f4ed38d8e0e645ca2277e"
    FOLDER_NAME="jdk-17.0.2"
    ;;
  21)
    JDK_VERSION="21"
    JDK_BUILD="35"
    JDK_HASH="ddf28910d10c4b2c9f3b3c375f553fe8"
    FOLDER_NAME="jdk-21"
    ;;
  *)
    echo -e "${RED}Versión no soportada. Usa 8, 11, 17 o 21.${NC}"
    exit 1
    ;;
esac

JDK_TAR="jdk-${JDK_VERSION}_linux-x64_bin.tar.gz"
JDK_URL="https://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}+${JDK_BUILD}/${JDK_HASH}/${JDK_TAR}"

echo -e "${WHITE}Descargando Oracle JDK $VERSION...${NC}"
wget --no-cookies --no-check-certificate \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  -O "$JDK_TAR" "$JDK_URL"

if [ ! -f "$JDK_TAR" ]; then
  echo -e "${RED}❌ Descarga fallida. Verifica la conexión o los datos del JDK.${NC}"
  exit 1
fi

tar -xzf "$JDK_TAR"
rm "$JDK_TAR"

update-alternatives --install /usr/bin/java java "$INSTALL_DIR/$FOLDER_NAME/bin/java" 1
update-alternatives --install /usr/bin/javac javac "$INSTALL_DIR/$FOLDER_NAME/bin/javac" 1
update-alternatives --set java "$INSTALL_DIR/$FOLDER_NAME/bin/java"
update-alternatives --set javac "$INSTALL_DIR/$FOLDER_NAME/bin/javac"

echo -e "\n${WHITE}✔ Oracle Java $VERSION instalado correctamente.${NC}"
java -version

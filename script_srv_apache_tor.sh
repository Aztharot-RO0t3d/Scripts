#!/bin/bash

# Colores para el texto
verde="\033[0;32m"
rojo="\033[0;31m"
neutro="\033[0m"

echo -e "${verde}Iniciando configuración automática de Apache y Tor...${neutro}"

# Verificar si Apache está instalado
if ! command -v httpd &> /dev/null; then
    echo -e "${rojo}Apache no está instalado. Instalando Apache...${neutro}"
    brew install httpd
    echo -e "${verde}Apache instalado correctamente.${neutro}"
else
    echo -e "${verde}Apache ya está instalado.${neutro}"
fi

# Verificar si Tor está instalado
if ! command -v tor &> /dev/null; then
    echo -e "${rojo}Tor no está instalado. Instalando Tor...${neutro}"
    brew install tor
    echo -e "${verde}Tor instalado correctamente.${neutro}"
else
    echo -e "${verde}Tor ya está instalado.${neutro}"
fi

# Configuración de Apache
HTTPD_CONF="/usr/local/etc/httpd/httpd.conf"
if [ -f "$HTTPD_CONF" ]; then
    echo -e "${verde}El archivo de configuración de Apache existe.${neutro}"
else
    echo -e "${rojo}El archivo de configuración de Apache no existe. Creándolo...${neutro}"
    sudo touch "$HTTPD_CONF"
fi

echo -e "${verde}Configurando Apache...${neutro}"

# Configurar httpd.conf
grep -q "Listen 80" "$HTTPD_CONF" || echo "Listen 80" | sudo tee -a "$HTTPD_CONF"
grep -q 'DocumentRoot "/usr/local/var/www"' "$HTTPD_CONF" || echo 'DocumentRoot "/usr/local/var/www"' | sudo tee -a "$HTTPD_CONF"
grep -q "<Directory \"/usr/local/var/www\">" "$HTTPD_CONF" || echo -e '<Directory "/usr/local/var/www">\n    Options Indexes FollowSymLinks\n    AllowOverride All\n    Require all granted\n</Directory>' | sudo tee -a "$HTTPD_CONF"

echo -e "${verde}Apache configurado correctamente.${neutro}"

# Reiniciar Apache
echo -e "${verde}Reiniciando Apache...${neutro}"
sudo apachectl restart

# Configuración de Tor
TORRC="/usr/local/etc/tor/torrc"
if [ -f "$TORRC" ]; then
    echo -e "${verde}El archivo de configuración de Tor existe.${neutro}"
else
    echo -e "${rojo}El archivo de configuración de Tor no existe. Creándolo...${neutro}"
    sudo touch "$TORRC"
fi

echo -e "${verde}Configurando Tor...${neutro}"

# Configurar torrc
grep -q "HiddenServiceDir /usr/local/var/lib/tor/hidden_service/" "$TORRC" || echo "HiddenServiceDir /usr/local/var/lib/tor/hidden_service/" | sudo tee -a "$TORRC"
grep -q "HiddenServicePort 80 127.0.0.1:80" "$TORRC" || echo "HiddenServicePort 80 127.0.0.1:80" | sudo tee -a "$TORRC"

# Crear directorio de servicio oculto
if [ ! -d "/usr/local/var/lib/tor/hidden_service/" ]; then
    echo -e "${rojo}Directorio de servicio oculto no existe. Creándolo...${neutro}"
    sudo mkdir -p /usr/local/var/lib/tor/hidden_service/
    sudo chown -R $(whoami) /usr/local/var/lib/tor/hidden_service/
    sudo chmod 700 /usr/local/var/lib/tor/hidden_service/
    echo -e "${verde}Directorio de servicio oculto creado.${neutro}"
else
    echo -e "${verde}Directorio de servicio oculto ya existe.${neutro}"
fi

# Reiniciar Tor
echo -e "${verde}Reiniciando Tor...${neutro}"
tor &

echo -e "${verde}Configuración completada con éxito. Apache y Tor están listos para usarse.${neutro}"


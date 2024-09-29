#!/bin/bash

# Actualizar lista de paquetes
sudo apt-get update

# Instalar drivers y firmware comunes
sudo apt-get install -y \
    linux-firmware \
    firmware-linux \
    firmware-linux-nonfree \
    firmware-b43-installer \
    firmware-brcm80211 \
    firmware-iwlwifi \
    firmware-realtek \
    firmware-atheros \
    firmware-amd-graphics \
    firmware-misc-nonfree

# Instalar herramientas de diagnóstico de hardware
sudo apt-get install -y \
    hwinfo \
    lshw \
    pciutils \
    usbutils

# Limpieza de paquetes innecesarios
sudo apt-get autoremove -y

# Actualización de drivers del sistema
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Mensaje de finalización
echo "Instalación de drivers y firmware completada. Es recomendable reiniciar el sistema para aplicar los cambios."

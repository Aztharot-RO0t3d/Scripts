#!/bin/bash

print_msg() {
    echo -e "\n\e[1;32m$1\e[0m\n"
}

if ! command -v brew &> /dev/null; then
    print_msg "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    print_msg "Homebrew ya está instalado."
fi

print_msg "Actualizando y limpiando Homebrew..."
brew update
brew upgrade
brew cleanup

print_msg "Agregando repositorios para herramientas de seguridad..."
brew tap homebrew/cask
brew tap homebrew/core
brew tap caffix/amass
brew tap go-task/task

tools=(
    "nmap"
    "wireshark"
    "john"
    "metasploit"
    "hydra"
    "nikto"
    "sqlmap"
    "aircrack-ng"
    "amass"
    "task"
)

print_msg "Instalando herramientas de Kali Linux compatibles con macOS..."
for tool in "${tools[@]}"; do
    if brew list -1 | grep -q "^${tool}\$"; then
        print_msg "La herramienta ${tool} ya está instalada."
    else
        print_msg "Instalando ${tool}..."
        brew install "${tool}"
    fi
done

print_msg "Buscando herramientas adicionales de Kali Linux compatibles..."
search_results=$(brew search kali)

if [ -z "$search_results" ]; then
    print_msg "No se encontraron herramientas adicionales relacionadas con Kali Linux."
else
    print_msg "Herramientas adicionales disponibles:"
    echo "$search_results"
    print_msg "Para instalarlas, utiliza 'brew install <nombre-de-la-herramienta>'."
fi

print_msg "Instalación completa. ¡Disfruta de tus herramientas de seguridad en macOS!"


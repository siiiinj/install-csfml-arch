#!/bin/bash

# Vérifier si l'utilisateur a les privilèges d'administration
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant qu'administrateur" 
   exit 1
fi

# Mettre à jour les dépôts et installer les outils nécessaires
pacman -Syu --noconfirm
pacman -S --noconfirm base-devel git cmake

# Cloner le référentiel CSFML depuis GitHub
git clone https://github.com/SFML/CSFML.git
cd CSFML

# Créer un répertoire build et s'y déplacer
mkdir build
cd build

# Configurer et compiler CSFML
cmake ..
make
make install

# Nettoyer après l'installation
cd ../..
rm -rf CSFML

echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> ~/.zshrc

echo "CSFML a été installé avec succès sur votre système Arch Linux."


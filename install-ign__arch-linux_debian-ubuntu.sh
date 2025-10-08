#!/bin/bash

# Vérifier si zenity est installé
if ! command -v zenity &> /dev/null; then
  echo "zenity n'est pas installé. Installation en cours..."
  if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
    sudo pacman -Syu --noconfirm zenity
  else
    sudo apt update
    sudo apt install -y zenity
  fi
fi

# Définir l'URL du fichier dep-fr-ign.txt
url_dep_ign="https://raw.githubusercontent.com/InformatiquePro/carte-ign-france/refs/heads/main/dep-fr-ign.txt"

# Vérifier si le fichier dep-fr-ign.txt existe, sinon le télécharger
if [ ! -f "dep-fr-ign.txt" ]; then
  zenity --info --title="Téléchargement nécessaire" --text="Le fichier dep-fr-ign.txt (ce fichier sert à télécherger les cartes) est introuvable. Cliquer sur Valider pour le télécharger."
  wget "$url_dep_ign" -O dep-fr-ign.txt
  if [ $? -ne 0 ]; then
    zenity --error --title="Erreur" --text="Impossible de télécharger le fichier dep-fr-ign.txt. Vérifiez votre connexion Internet et réessayez."
    exit 1
  fi
fi


zenity --info --title="Carte IGN" --text="Ce script utilise QGIS, un logiciel open-source de cartographie, et p7zip-full pour décompresser les fichiers. Les cartes sont récupérées sur les serveurs IGN-France. L'utilisation des cartes implique l'acceptation des conditions d'utilisation de IGN-France. Pour plus d'informations : https://geoservices.ign.fr/cgu-licences."

# Lire le fichier dep-fr-ign.txt dans un tableau associatif
declare -A urls fichiers_gpkg
while IFS=";" read -r dep url fichier_gpkg; do
  urls["$dep"]="$url"
  fichiers_gpkg["$dep"]="$fichier_gpkg"
done < dep-fr-ign.txt

# Demander le numéro de département
departement=$(zenity --entry --title="Choix du département" --text="Entrez le numéro du département que vous souhaitez télécharger :")

# Vérifier si le département existe dans le fichier
if [ -z "${urls[$departement]}" ]; then
  zenity --error --title="Erreur" --text="Département non supporté. Veuillez vérifier que votre département est supporté ici : https://github.com/InformatiquePro/carte-ign-france/blob/main/departement-compatible.md "
  exit 1
fi

# Vérifier si p7zip-full est installé
if ! command -v 7z &> /dev/null; then
  echo "p7zip-full n'est pas installé. Installation en cours..."
  if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
    sudo pacman -Syu --noconfirm p7zip
  else
    sudo apt update
    sudo apt install -y p7zip-full
  fi
fi

# Vérifier si QGIS est installé
if ! command -v qgis &> /dev/null; then
  echo "QGIS n'est pas installé. Installation en cours..."
  if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
    sudo pacman -Syu --noconfirm qgis
  else
    sudo apt update
    sudo apt install -y qgis
  fi
fi

# Télécharger la carte
url="${urls[$departement]}"
fichier_gpkg="${fichiers_gpkg[$departement]}"
wget "$url" -O "carte_$departement.7z"
if [ $? -ne 0 ]; then
  zenity --error --title="Erreur" --text="Le téléchargement du fichier a échoué. Vérifiez votre connexion Internet et réessayez."
  exit 1
fi

# Décompresser l'archive
7z x "carte_$departement.7z"
if [ $? -ne 0 ]; then
  zenity --error --title="Erreur" --text="La décompression du fichier a échoué. Assurez-vous que p7zip-full est correctement installé."
  exit 1
fi

zenity --info --title="Ré-ouverture" --text="Si vous voulez ré-ouvrir les cartes, ne rééxécutez pas ce script, ouvrez plutot ce fichier : $fichier_gpkg dans QGIS. "

# Ouvrir le fichier dans QGIS
if [ -f "$fichier_gpkg" ]; then
  qgis "$fichier_gpkg"
else
  zenity --error --title="Erreur" --text="Le fichier GPKG n'a pas été trouvé après décompression. Vérifiez que l'archive contient bien les données nécessaires."
  exit 1
fi

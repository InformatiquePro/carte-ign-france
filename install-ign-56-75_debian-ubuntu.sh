#!/bin/bash

zenity --info --title="Carte IGN" --text="Ce script utilise QGIS, un logiciel open-source de cartographie, et p7zip-full pour décompresser les fichiers. Les cartes sont récupérées sur les serveurs IGN-France. L'utilisation des cartes implique l'acceptation des conditions d'utilisation de IGN-France. Pour plus d'informations : https://geoservices.ign.fr/cgu-licences."

zenity --warning --title="Confirmation" --text="Vous êtes sur le point de continuer. Si l'utilisation de ce script n'est pas conforme au politique de IGN-FRANCE, InformatiquePro sera en aucun cas responsable de votre manquement au condition d'utilisation IGN-FRANCE."

zenity --info --title="Stockage" --text="Il est nécéssaire en moyenne d'au moins 4GO de stockage libre."


# Demander le numéro de département
departement=$(zenity --entry --title="Choix du département" --text="Entrez le numéro du département que vous souhaitez télécharger (ex: 56 pour Morbihan, 75 pour Paris) :")

# Vérifier si une entrée a été fournie
if [ -z "$departement" ]; then
  zenity --error --title="Erreur" --text="Aucun numéro de département fourni. Le script va s'arrêter."
  exit 1
fi

# Vérifier si p7zip-full est installé
if ! dpkg -s p7zip-full &> /dev/null; then
  echo "p7zip-full n'est pas installé. Installation en cours..."
  sudo apt update
  sudo apt install -y p7zip-full
fi

# Vérifier si QGIS est installé
if ! dpkg -s qgis &> /dev/null; then
  echo "QGIS n'est pas installé. Installation en cours..."
  sudo apt update
  sudo apt install -y qgis
fi

# Définir les URLs et les chemins selon le département
case "$departement" in
  56)
    url="https://data.geopf.fr/telechargement/download/BDTOPO/BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15/BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15.7z"
    fichier_gpkg="BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15/BDTOPO/1_DONNEES_LIVRAISON_2024-09-00152/BDT_3-4_GPKG_LAMB93_D056-ED2024-09-15/BDT_3-4_GPKG_LAMB93_D056-ED2024-09-15.gpkg"
    ;;
  75)
    url="https://data.geopf.fr/telechargement/download/BDTOPO/BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D075_2024-09-15/BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D075_2024-09-15.7z"
    fichier_gpkg="BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D075_2024-09-15/BDTOPO/1_DONNEES_LIVRAISON_2024-09-00152/BDT_3-4_GPKG_LAMB93_D075-ED2024-09-15/BDT_3-4_GPKG_LAMB93_D075-ED2024-09-15.gpkg"
    ;;
  *)
    zenity --error --title="Erreur" --text="Département non supporté. Actuellement, seuls les départements 56 et 75 sont pris en charge."
    exit 1
    ;;
esac

# Télécharger la carte
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

zenity --info --title="Ré-ouverture" --text="Si vous voulez ré-ouvrir les cartes, ne rééxécutez pas ce script, ouvrez plutot le dossier télécharger, ensuite BDTOPO, après _DONNEES_LIVRAISON_2024-09-00152, ensuite BDT_3-4_GPKG_LAMB93_D0/votre-département/, et enfin ouvrez ce fichier : BDT_3-4_GPKG_LAMB93_D0/votre-département/.gpkg dans qgis. "

# Ouvrir le fichier .gpkg dans QGIS
if [ -f "$fichier_gpkg" ]; then
  qgis "$fichier_gpkg"
else
  zenity --error --title="Erreur" --text="Le fichier GPKG n'a pas été trouvé après décompression. Vérifiez que l'archive contient bien les données nécessaires."
  exit 1
fi


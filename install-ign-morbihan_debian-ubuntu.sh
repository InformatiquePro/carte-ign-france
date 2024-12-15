#!/bin/bash

zenity --info --title="Carte du Morbihan" --text="Ce script utilise QGIS, un logiciel open-source de donner cartographique, p7zip-full un équivalent de 7zip pour linux open-source pour décompresser les fichiers 7z. La carte est récupérer sur les serveurs IGN-FRANCE. Cela implique donc dès l'utilisation de ces cartes l'acceptation imédiate de toutes les conditions d'utilisation de IGN-FRANCE. Pour plus d'information, consulter : https://geoservices.ign.fr/cgu-licences . Si vous penser que votre utilisation de ces cartes n'est pas conforme, fermer la fenêtre de terminal sans cliquer sur Valider."

zenity --warning --title="Confirmation" --text="Vous êtes sur le point de continuer. Si l'utilisation de ce script n'est pas conforme au politique de IGN-FRANCE, InformatiquePro sera en aucun cas responsable de votre manquement au condition d'utilisation IGN-FRANCE."

zenity --info --title="Stockage" --text="Il est nécéssaire en moyenne d'au moins 4GO de stockage libre."


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

# Télécharger la carte du Morbihan
wget https://data.geopf.fr/telechargement/download/BDTOPO/BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15/BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15.7z

# Décompresser l'archive
7z x BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15.7z

# Afficher un message de confirmation

zenity --info --title="Carte du Morbihan" --text="La carte du Morbihan est prête pour être charger dans QGIS. Séléctionner Valider pour l'ouvrir. Si vous compter denouveau réouvrir la carte, ne rééxécuter pas ce script, car ça retéléchargera tous les fichier. Lancer dans un terminal ou ce dossier est ouvert : qgis BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15/BDTOPO/1_DONNEES_LIVRAISON_2024-09-00152/BDT_3-4_GPKG_LAMB93_D056-ED2024-09-15/BDT_3-4_GPKG_LAMB93_D056-ED2024-09-15.gpkg Cette commande fonctionne uniquement si vous n'avez pas modifier le nom des fichiers télécharger."

# Ouvrir le fichier .gpkg dans QGIS
qgis BDTOPO_3-4_TOUSTHEMES_GPKG_LAMB93_D056_2024-09-15/BDTOPO/1_DONNEES_LIVRAISON_2024-09-00152/BDT_3-4_GPKG_LAMB93_D056-ED2024-09-15/BDT_3-4_GPKG_LAMB93_D056-ED2024-09-15.gpkg



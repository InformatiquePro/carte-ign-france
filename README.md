
# 🗺️ Carte IGN France 📡

![Statut du Projet](https://img.shields.io/badge/status-en%20développement-yellow)
![Compatibilité](https://img.shields.io/badge/compatibilité-Debian%20%7C%20Arch-blue)
![Contributions](https://img.shields.io/badge/contributions-bienvenues-brightgreen)

Un script shell simple et efficace pour télécharger les SCANs BDTOPO officiels de l'IGN (Institut National de l'Information Géographique et Forestière).

<p align="center">
  <img src="https://raw.githubusercontent.com/asciinema/asciinema-server/master/app/assets/images/logo_big.gif" alt="Démonstration du script" width="70%"/>
</p>

---

## ⚠️ Avertissements Importants

> [!CAUTION]
> ### Projet en cours de développement (WIP)
> Tous les départements français ne sont pas encore compatibles ou testés. La liste est activement mise à jour. Merci de votre patience !
> L'IGN à déplacer les fichiers de carte à d'autre endroit. Pour l'instant je n'ai pas le temps d'adapter ce scripte à ces changements.   **CE SCRIPTE N'EST DONC PLUS EN MESURE DE FONCTIONNER**

> [!IMPORTANT]
> ### Compatibilité du Système
> Ce script est conçu *uniquement* pour les distributions basées sur :
> * ✅ **Debian / Ubuntu** (et dérivées comme Linux Mint, Pop!_OS)
> * ✅ **Arch Linux / Manjaro** (et dérivées)
>
> ⛔ Il **N'EST PAS** compatible avec les distributions basées sur RHEL (Fedora, CentOS, Rocky Linux) en raison de différences dans la gestion des paquets et des dépendances.

---

## ✨ Fonctionnalités

* **Téléchargement Simplifié** : Une seule commande pour lancer le processus.
* **Menu Interactif** : Choisissez votre département dans une liste claire.
* **Léger et Rapide** : Un simple script shell, sans dépendances lourdes.
* **Données à Jour** : Récupère les données BDTOPO directement depuis les serveurs de l'IGN.
* **Open Source** : Le code est transparent et ouvert aux contributions.

## 🌍 Départements Compatibles

La liste des départements disponibles est maintenue dans un fichier séparé pour plus de clarté.

➡️ **[Cliquez ici pour voir la liste des départements compatibles](https://github.com/InformatiquePro/carte-ign-france/blob/main/departement-compatible.md)**

Si votre département n'est pas dans la liste, c'est qu'il n'a pas encore été ajouté ou testé.

---

## 🚀 Installation et Lancement

Aucune installation n'est requise, suivez simplement ces étapes dans votre terminal :

**1. Clonez le dépôt :**
```sh
git clone https://github.com/InformatiquePro/carte-ign-france.git
```
**2. Accédez au dossier :**
```sh
cd carte-ign-france
```
**3. Donnez les droits d'exécution au script :**
```sh
chmod +x carte-ign-france.sh
```
**4. Lancez le script !**
```sh
./install-ign__arch-linux_debian-ubuntu.sh
```

# Image distribuable du site Calvinball Consortium

Ces ficheirs de configuration ont pour but de pouvoir créer et re-créer de façon répétable une image du site Calvinball Consortium, que ce soit dans une machine virtuelle ou sur un service web.

Le système de virtualisation supporté pour Windows est QEMU avec le back-end Hyper-V.

Si vous n'utilisez pas Hyper-V, Vagrant devrait marcher aussi avec le Vagrantfile fourni (Hyper-V ne supporte pas la redirection de ports).

## Créer la machine virtuelle sous Windows

### Prérequis

- Windows 10 ou supérieur
- Installer Hyper-V : dans Powershell en administrateur,

```Powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

- Installer QEMU : [Télécharger QEMU](https://qemu.weilnetz.de/w64/)

### Installation de la machine virtuelle

- créer un fichier .vault_pass et mettre dedans le mot de passe des vault.
- copier `id_rsa` et `id_rsa.pub` à la racine du repo
- Exécuter `webserver.bat`: le script télécharge Python et lance un serveur web local pour cloud-init.
- Ouvrir un autre terminal et lancer `run_qemu.bat`. Le script télécharge une image de Debian, lance cloud-init, récupère les fichiers ansible depuis l'hôte et lance le playbook.

La machine virtuelle se lance et doit se pré-configurer à l'aide des fichiers `cloud-init` servis par le serveur web, puis ansible prend le relais !

### Et maintenant, ansible

On peut lancer le playbook ansible d'un repo git en une commande

```
ansible-pull -u https://github.com/yattoz/calvinball-server-setup playbook.yml --verbose
```

Ca crée les utilisateurs, télécharge les paquets, installe plein de trucs.

## Développer dans QEMU

SSH est ouvert:

```
ssh -p 2222 developer@localhost
```

### Mémo d'installation

- move les dossiers utiles dans un dossier temporaire
  + ~/tout
  + nginx folder
  + .bashrc

- installer debian 12

tweaks:
- remove php (now nextcloud runs on docker)
- change sshd config 
  + PermitRootLogin: no
- fix nginx conf file


- installer ansible
- cloner le repo du ansible
- créer le .vault_pass avec le password
- créer les clés id_rsa id_rsa.pub
- lancer le playbook
- check les mots de passe (je sais pas si ansible les réécrit ou pas)
  + si réécrits, les réinitialiser
- lance le playbook graduate
- move les dossiers (audio, docs, resources, images) to assets location /calvinballconsortium
- check le nginx + site + tous les sous-domaines
- check le mumble, ça ne devrait pas avoir changé d'un poil
- check le crontab
- check les accès au serveur de backup et le xmpp-notif
- check le cockpit, son certif (normalement géré par le reverse proxy nginx?)

- check permissions dans /calvinballconsortium, tout doit appartenir au groupe developer par défaut
- créer les symlinks dans tous les users


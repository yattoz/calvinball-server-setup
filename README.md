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

- Installer QEMU : [Télécharger QEMU](https://qemu.weilnetz.de/w64/qemu-w64-setup-20230424.exe)

### Installation de la machine virtuelle

- créer un fichier .vault_pass et mettre dedans le mot de passe des vault.
- Exécuter `webserver.bat`: le script télécharge Python et lance un serveur web local pour cloud-init.
- Ouvrir un autre terminal et lancer `run_qemu.bat`. Le script télécharge une image de Debian, lance cloud-init, récupère les fichiers ansible depuis l'hôte et lance le playbook.

La machine virtuelle se lance et doit se pré-configurer à l'aide des fichiers `cloud-init` servis par le serveur web, puis ansible prend le relais !

### Et maintenant, ansible

On peut lancer le playbook ansible d'un repo git en une commande

```
ansible-pull -u https://github.com/yattoz/calvinball-server-setup playbook.yml --verbose
```

Ca crée les utilisateurs, télécharge les paquets, installe plein de trucs.
# Image distribuable du site Calvinball Consortium

Ces ficheirs de configuration ont pour but de pouvoir créer et re-créer de façon répétable une image du site Calvinball Consortium, que ce soit dans une machine virtuelle ou sur un service web.

## Créer la machine virtuelle sous Windows

### Prérequis

- Windows 10 ou supérieur
- Installer Hyper-V, le moteur d'exécution de machine virtuelle de Windows : dans Powershell en administrateur,

```Powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

- Installer QEMU, le gestionnaire de machines virtuelles : [Télécharger QEMU](https://qemu.weilnetz.de/w64/qemu-w64-setup-20230424.exe)

### Installation de la machine virtuelle

- Exécuter `debian_hyperv.bat`: le script télécharge une image Debian Cloud et Python portable pour servir de serveur web
- Attendre que le serveur web Python soit lancé
- Dans une autre fenêtre, lancer `run_qemu.bat`.

La machine virtuelle se lance et doit se pré-configurer à l'aide des fichiers `cloud-init` servis par le serveur web.

Dans le cloud-init, ansible doit prendre le relais !

### Et maintenant, ansible


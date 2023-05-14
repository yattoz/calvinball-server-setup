::curl -L -C - https://cloudbase.it/downloads/qemu-img-win-x64-2_3_0.zip -o a.zip
::tar -xf a.zip
curl -L -C - https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -o dg.qcow2
curl -L -C - https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.qcow2 -o dn.qcow2
del i.qcow2
copy dg.qcow2 i.qcow2
:: curl -L -C - https://cloud.debian.org/images/cloud/buster/latest/debian-10-nocloud-amd64.qcow2 -o i.qcow2
curl -L -C - https://www.python.org/ftp/python/3.11.3/python-3.11.3-embed-amd64.zip -o py.zip
tar -xf py.zip
.\python.exe -m http.server --directory . 

:: .\qemu-img.exe resize .\i.qcow2 +2G
:: .\qemu-img.exe convert -O vhdx i.qcow2 debian.vhdx
::.\qemu-img.exe resize .\debian.vhdx +10G

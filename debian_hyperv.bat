
curl -L -C - https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -o dg.qcow2

if "%1"=="--clean" ( 
    del i.qcow2
)

if not exist i.qcow2 (
    copy dg.qcow2 i.qcow2
    "C:\Program Files\QEMU\qemu-img" resize i.qcow2 30G
) 

if not exist python (
    curl -L -C - https://www.python.org/ftp/python/3.11.3/python-3.11.3-embed-amd64.zip -o py.zip
    mkdir python
    tar -xf py.zip -C python
    del py.zip
)
.\python\python.exe -m http.server --directory . 

:: Download image if not on disk yet
if not exist dg.qcow2 (
    curl -L -C - https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -o dg.qcow2
)

if "%1"=="--clean" ( 
    del i.qcow2
)

if not exist i.qcow2 (
    copy dg.qcow2 i.qcow2
    "C:\Program Files\QEMU\qemu-img" resize i.qcow2 30G
)

:: QEMU is meant for testing, so we use a local web server to run the cloud-init config: 
"C:\Program Files\qemu\qemu-system-x86_64.exe"^
 -device e1000,netdev=net0 ^
 -netdev user,id=net0,hostfwd=tcp::5555-:22,hostfwd=tcp::9999-:9090,hostfwd=tcp::8888-:80,hostfwd=tcp::4443-:443 ^
 -machine accel=whpx  -m 4096 -nographic ^
 -hda i.qcow2 ^
 -smbios type=1,serial="ds=nocloud-net;s=http://10.0.2.2:8000/"

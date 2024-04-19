
:: Download image if not on disk yet
::curl -L -C - https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -o dg.qcow2


if not exist dg.qcow2 (
    curl -L -C - https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 -o dg.qcow2
)

if "%1"=="--clean" ( 
    del i.qcow2
)

if not exist i.qcow2 (
    copy dg.qcow2 i.qcow2
    "C:\Program Files\QEMU\qemu-img" resize i.qcow2 30G
)

:: QEMU is meant for testing, so we use a local web server to run the cloud-init config: 
:: service host port -> vm port
:: cockpit 9999 -> 9090
:: http 8888 -> 80
:: https 4443 -> 443
:: hugo  11313 -> 1313
:: nexcloud-aio 38080 -> 8080
:: ssh 2222 -> 22
"C:\Program Files\qemu\qemu-system-x86_64.exe"^
 -device e1000,netdev=net0 ^
 -netdev user,id=net0,hostfwd=tcp::5555-:22,hostfwd=tcp::9999-:9090,hostfwd=tcp::8888-:80,hostfwd=tcp::4443-:443,hostfwd=tcp::11313-:1313,hostfwd=tcp::38080-:8080,hostfwd=tcp::2222-:22 ^
 -machine accel=whpx -smp 12 -m 8192 -nographic ^
 -hda i.qcow2 ^
 -smbios type=1,serial="ds=nocloud-net;s=http://10.0.2.2:8000/"

:: QEMU is meant for testing, so we use a local web server to run the cloud-init config: 
"C:\Program Files\qemu\qemu-system-x86_64.exe" -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22 -machine accel=whpx  -m 4096 -nographic -hda i.qcow2 -smbios type=1,serial="ds=nocloud-net;s=http://10.0.2.2:8000/"

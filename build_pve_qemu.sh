#!/bin/bash
sudo apt-get install -y libacl1-dev libaio-dev libattr1-dev libcap-ng-dev libcurl4-gnutls-dev libepoxy-dev libfdt-dev libgbm-dev libgnutls28-dev libiscsi-dev libjpeg-dev libnuma-dev libpci-dev libpixman-1-dev libproxmox-backup-qemu0-dev librbd-dev libsdl1.2-dev libseccomp-dev libslirp-dev libspice-protocol-dev libspice-server-dev libsystemd-dev liburing-dev libusb-1.0-0-dev libusbredirparser-dev libvirglrenderer-dev meson python3-sphinx python3-sphinx-rtd-theme quilt xfslibs-dev
ls
df -h
git clone git://git.proxmox.com/git/pve-qemu.git
cd pve-qemu
# pve8 9.2.0-7
git reset --hard 245689b9ae4120994de29b71595ea58abac06f3c
# pve9 10.1.2-5
# git reset --hard de7f8fe356c7b1d346c3c15c971f7a0dcd11e70e
sudo apt install devscripts -y
yes | sudo mk-build-deps --install
git submodule update --init --recursive
cp ../sedPatch-pve-qemu-kvm9-10-anti-dection.sh qemu/
cd qemu
meson subprojects download
chmod +x sedPatch-pve-qemu-kvm9-10-anti-dection.sh
bash sedPatch-pve-qemu-kvm9-10-anti-dection.sh
cp ../../smbios.h include/hw/firmware/smbios.h
cp ../../smbios.c hw/smbios/smbios.c
cp ../../bootsplash.jpg pc-bios/bootsplash.jpg # modify seabios bootsplash.jpg
sed -i "s/vgabios.bin/vgabios.bin',\n\t'bootsplash.jpg/g" pc-bios/meson.build # modify seabios bootsplash.jpg
sed -i 's/current_machine->boot_config.splash;/"\/usr\/share\/kvm\/bootsplash.jpg";/g' hw/nvram/fw_cfg.c # modify seabios bootsplash.jpg
sed -i 's/!object_dynamic_cast/object_dynamic_cast/g' hw/vfio/igd.c
git diff --submodule=diff > qemu-autoGenPatch.patch
cp qemu-autoGenPatch.patch ../

cd ..
make clean
make #改为一次编译
cd qemu/
git checkout .
cd ..

# strong reset project data
rm -Rf qemu/pc-bios
git reset --hard master
git submodule update --init --recursive --force
git checkout .
cd qemu/
git checkout .
git submodule update --init --recursive --force
git checkout .
cd ../..

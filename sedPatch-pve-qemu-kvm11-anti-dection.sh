#!/bin/bash
brand="ASUS" #这里修改品牌
echo "开始sed工作"
sed -i 's/QEMU v" QEMU_VERSION/'${brand}' v" QEMU_VERSION/g' block/vhdx.c
sed -i 's/QEMU VVFAT", 10/'${brand}' VVFAT", 10/g' block/vvfat.c
sed -i 's/QEMU Microsoft Mouse/'${brand}' Microsoft Mouse/g' chardev/msmouse.c
sed -i 's/QEMU Wacom Pen Tablet/'${brand}' Wacom Pen Tablet/g' chardev/wctablet.c
sed -i 's/QEMU vhost-user-gpu/'${brand}' vhost-user-gpu/g' contrib/vhost-user-gpu/vhost-user-gpu.c
sed -i 's/build_append_padded_str(array, desc->oem_id, 6, '\''\\0'\'');/build_append_padded_str(array, ACPI_BUILD_APPNAME6, 6, '\''\\0'\'');/' hw/acpi/aml-build.c
sed -i 's/g_array_append_vals(array, ACPI_BUILD_APPNAME8, 4);/g_array_append_vals(array, "ACPI", 4);/' hw/acpi/aml-build.c
sed -i 's/build_append_int_noprefix(tbl, 0 \/\* Unspecified \*\/, 1);/build_append_int_noprefix(tbl, 1 \/\* Desktop \*\/, 1);/' hw/acpi/aml-build.c
sed -i 's/build_append_padded_str(tbl, "QEMU", 8, '\''\\0'\'');/build_append_padded_str(tbl, "", 8, '\''\\0'\'');/' hw/acpi/aml-build.c

grep "do this once" hw/acpi/vmgenid.c >/dev/null
if [ $? -eq 0 ]; then
	echo "hw/acpi/vmgenid.c 文件只能处理一次！以前已经处理，本次不执行！"
else
	sed -i 's/    Aml \*ssdt/       \/\/FUCK YOU~~~\n       return;\/\/do this once\n    Aml \*ssdt/g' hw/acpi/vmgenid.c
	echo "hw/acpi/vmgenid.c 文件处理完成（第一次处理，只处理一次）"
fi
sed -i 's/"QEMUQEQEMUQEMU/"ASUSASASUSASUS/g' hw/acpi/core.c
sed -i 's/"QEMU/"'${brand}'/g' hw/acpi/core.c
sed -i "s/QEMU 'SBSA Reference' ARM Virtual Machine/"${brand}" 'SBSA Reference' ARM Real Machine/g" hw/arm/sbsa-ref.c
sed -i 's/QEMU Sun Mouse/'${brand}' Sun Mouse/g' hw/char/escc.c
sed -i 's/info->vendor = "RHT"/info->vendor = "DEL"/g' hw/display/edid-generate.c
sed -i 's/QEMU Monitor/'${brand}' Monitor/g' hw/display/edid-generate.c
sed -i 's/uint16_t model_nr = 0x1234;/uint16_t model_nr = 0xA05F;/g' hw/display/edid-generate.c

grep "do this once" hw/i386/acpi-build.c >/dev/null
if [ $? -eq 0 ]; then
	echo "hw/i386/acpi-build.c 文件只能处理一次！以前已经处理，本次不执行！"
else
	sed -i '/static void build_dbg_aml(Aml \*table)/,/ /s/{/{\n     return;\/\/do this once/g' hw/i386/acpi-build.c
	sed -i '/create fw_cfg node/,/}/s/}/}*\//g' hw/i386/acpi-build.c
	sed -i '/create fw_cfg node/,/}/s/{/\/*{/g' hw/i386/acpi-build.c
	echo "hw/i386/acpi-build.c 文件处理完成（第一次处理，只处理一次）"
fi
sed -i 's/"QEMU/"'${brand}'/g' hw/i386/fw_cfg.c
sed -i 's/"QEMU Virtual CPU/"CPU/g' hw/i386/pc.c
sed -i 's/pcmc->smbios_defaults = true;/pcmc->smbios_defaults = false;/' hw/i386/pc.c
sed -i 's/"QEMU/"'${brand}'/g' hw/i386/pc_piix.c
sed -i 's/Standard PC (i440FX + PIIX, 1996)/'${brand}' M4A88TD-Mi440fx/g' hw/i386/pc_piix.c
sed -i 's/"QEMU/"'${brand}'/g' hw/i386/pc_q35.c
sed -i 's/Standard PC (Q35 + ICH9, 2009)/'${brand}' M4A88TD-Mq35/g' hw/i386/pc_q35.c
sed -i 's/mc->name, pcmc->smbios_legacy_mode,/"'${brand}'-PC", pcmc->smbios_legacy_mode,/g' hw/i386/pc_q35.c
sed -i 's/padstr8(buf + 8, 8, "QEMU");/padstr8(buf + 8, 8, "Samsung");/' hw/ide/atapi.c
sed -i 's/padstr8(buf + 16, 16, "QEMU DVD-ROM");/padstr8(buf + 16, 16, "DVD-ROM");/' hw/ide/atapi.c
sed -i 's/snprintf(s->drive_serial_str, sizeof(s->drive_serial_str), "QM%05d", s->drive_serial);/s->drive_serial_str[0] = '\''\\0'\'';  \/\/ Empty string fallback instead of QEMU default/' hw/ide/core.c
sed -i 's/strcpy(s->drive_model_str, "QEMU DVD-ROM");/strcpy(s->drive_model_str, "HL-DT-ST BD-RE WH16NS60");/' hw/ide/core.c
sed -i 's/strcpy(s->drive_model_str, "QEMU MICRODRIVE");/strcpy(s->drive_model_str, "Hitachi HMS360404D5CF00");/' hw/ide/core.c
sed -i 's/strcpy(s->drive_model_str, "QEMU HARDDISK");/strcpy(s->drive_model_str, "Samsung SSD 980 500GB");/' hw/ide/core.c
sed -i 's/0x09, 0x03, 0x00, 0x64, 0x64, 0x01, 0x00/0x09, 0x03, 0x00, 0x64, 0x64, 0x9a, 0x02/g' hw/ide/core.c  #ide sata 通电时间power on hours改为666小时 0x029a
sed -i 's/0x0c, 0x03, 0x00, 0x64, 0x64, 0x00, 0x00/0x0c, 0x03, 0x00, 0x64, 0x64, 0x9a, 0x02/g' hw/ide/core.c  #ide sata 通电次数power cycle count改为666次 0x029a
sed -i 's/"QEMU/"'${brand}'/g' hw/input/adb-kbd.c
sed -i 's/"QEMU/"'${brand}'/g' hw/input/adb-mouse.c
sed -i 's/"QEMU/"'${brand}'/g' hw/input/hid.c
sed -i 's/"QEMU/"'${brand}'/g' hw/input/ps2.c
sed -i 's/"QEMU Virtio/"'${brand}'/g' hw/input/virtio-input-hid.c
sed -i 's/QEMU M68K Virtual Machine/'${brand}' M68K Real Machine/g' hw/m68k/virt.c
sed -i 's/"QEMU/"'${brand}'/g' hw/misc/pvpanic-isa.c
sed -i 's/aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0001")));/aml_append(dev, aml_name_decl("_HID", aml_string("UEFI0001")));/' hw/misc/pvpanic-isa.c
sed -i 's/"QEMU/"'${brand}'/g' hw/nvme/ctrl.c
sed -i 's/0x51454d5520434647ULL/0x4155535520434647ULL/g' hw/nvram/fw_cfg.c
sed -i 's/"QEMU/"'${brand}'/g' hw/nvram/fw_cfg-acpi.c
sed -i 's/"QEMU/"'${brand}'/g' hw/pci-host/gpex.c
sed -i 's/k->vendor_id = PCI_VENDOR_ID_REDHAT;/k->vendor_id = PCI_VENDOR_ID_INTEL;/' hw/pci-host/gpex.c
sed -i 's/k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_HOST;/k->device_id = PCI_DEVICE_ID_INTEL_P35_MCH;/' hw/pci-host/gpex.c
sed -i 's/"QEMU/"'${brand}'/g' hw/ppc/prep.c
sed -i 's/"QEMU/"'${brand}'/g' hw/ppc/e500plat.c
sed -i 's/qemu-e500/asus-e500/g' hw/ppc/e500plat.c
sed -i 's/"QEMU Virtual/"'${brand}'/g' hw/riscv/virt.c
sed -i 's/"KVM Virtual/"'${brand}'/g' hw/riscv/virt.c
sed -i 's/"QEMU/"'${brand}'/g' hw/riscv/virt.c
sed -i 's/s16s8s16s16s16/s11s4s51s41s91/g' hw/scsi/mptconfig.c
sed -i 's/QEMU MPT Fusion/'${brand}' MPT Fusion/g' hw/scsi/mptconfig.c
sed -i 's/"QEMU"/"'${brand}'"/g' hw/scsi/mptconfig.c
sed -i 's/0000111122223333/1145141919810000/g' hw/scsi/mptconfig.c
sed -i 's/"QEMU/"'${brand}'/g' hw/scsi/scsi-bus.c
sed -i 's/qemu_hw_version()/"999"/g' hw/scsi/scsi-bus.c #scsi bus version 4字符大小
sed -i 's/"QEMU/"'${brand}'/g' hw/scsi/megasas.c
sed -i 's/"QEMU/"'${brand}'/g' hw/scsi/scsi-disk.c
sed -i 's/qemu_hw_version()/"999"/g' hw/scsi/scsi-disk.c #scsi 固件version 5字符大小
sed -i 's/"QEMU/"'${brand}'/g' hw/scsi/spapr_vscsi.c
sed -i 's/"QEMU/"'${brand}'/g' hw/sd/sd.c
sed -i 's/"QEMU/"'${brand}'/g' hw/ufs/lu.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-audio.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-hub.c
sed -i 's/314159/114514/g' hw/usb/dev-hub.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-mtp.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-network.c
sed -i 's/"RNDIS\/QEMU/"RNDIS\/'${brand}'/g' hw/usb/dev-network.c
sed -i 's/400102030405/400114514405/g' hw/usb/dev-network.c
sed -i 's/s->vendorid = 0x1234/s->vendorid = 0x8086/g' hw/usb/dev-network.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-serial.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-smartcard-reader.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-storage.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-uas.c
sed -i 's/27842/33121/g' hw/usb/dev-uas.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/dev-wacom.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/u2f-emulated.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/u2f-passthru.c
sed -i 's/"QEMU/"'${brand}'/g' hw/usb/u2f.c
sed -i 's/"BOCHS/"INTEL/g' include/hw/acpi/aml-build.h
sed -i 's/"BXPC/"PC8086/g' include/hw/acpi/aml-build.h
sed -i 's/"QEMU0002/"'${brand}'0002/g' include/standard-headers/linux/qemu_fw_cfg.h
sed -i 's/0x51454d5520434647ULL/0x4155535520434647ULL/g' include/standard-headers/linux/qemu_fw_cfg.h
sed -i 's/"QEMU/"'${brand}'/g' migration/migration.c
sed -i 's/"QEMU/"'${brand}'/g' migration/rdma.c
sed -i 's/0x51454d5520434647ULL/0x4155535520434647ULL/g' pc-bios/optionrom/optionrom.h
sed -i 's/"QEMU/"'${brand}'/g' pc-bios/s390-ccw/virtio-scsi.h
sed -i 's/"QEMU/"'${brand}'/g' roms/seabios-hppa/src/fw/ssdt-misc.dsl
sed -i 's/KVMKVMKVM\\0\\0\\0/\\1\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0/g' target/i386/kvm/kvm.c
sed -i 's/QEMUQEMUQEMUQEMU/ASUSASUSASUSASUS/g' target/s390x/tcg/misc_helper.c
sed -i 's/"QEMU/"'${brand}'/g' target/s390x/tcg/misc_helper.c
sed -i 's/"KVM/"ATX/g' target/s390x/tcg/misc_helper.c
sed -i 's/t->bios_characteristics_extension_bytes\[1\] = 0x14;/t->bios_characteristics_extension_bytes\[1\] = 0x0F;/g' hw/smbios/smbios.c
sed -i 's/t->voltage = 0;/t->voltage = 0x8B;/g' hw/smbios/smbios.c
sed -i 's/t->external_clock = cpu_to_le16(0);/t->external_clock = cpu_to_le16(100);/g' hw/smbios/smbios.c
sed -i 's/t->l1_cache_handle = cpu_to_le16(0xFFFF);/t->l1_cache_handle = cpu_to_le16(0x0039);/g' hw/smbios/smbios.c
sed -i 's/t->l2_cache_handle = cpu_to_le16(0xFFFF);/t->l2_cache_handle = cpu_to_le16(0x003A);/g' hw/smbios/smbios.c
sed -i 's/t->l3_cache_handle = cpu_to_le16(0xFFFF);/t->l3_cache_handle = cpu_to_le16(0x003B);/g' hw/smbios/smbios.c
sed -i 's/t->processor_family = 0x01;/t->processor_family = 0xC6;/g' hw/smbios/smbios.c
sed -i 's/t->processor_characteristics = cpu_to_le16(0x02);/t->processor_characteristics = cpu_to_le16(0x04);/g' hw/smbios/smbios.c
sed -i 's/t->memory_type = 0x07;/t->memory_type = 0x18;/g' hw/smbios/smbios.c
sed -i 's/t->total_width = cpu_to_le16(0xFFFF);/t->total_width = cpu_to_le16(64);/g' hw/smbios/smbios.c
sed -i 's/t->data_width = cpu_to_le16(0xFFFF);/t->data_width = cpu_to_le16(64);/g' hw/smbios/smbios.c
sed -i 's/t->minimum_voltage = cpu_to_le16(0);/t->minimum_voltage = cpu_to_le16(1350);/g' hw/smbios/smbios.c
sed -i 's/t->maximum_voltage = cpu_to_le16(0);/t->maximum_voltage = cpu_to_le16(1500);/g' hw/smbios/smbios.c
sed -i 's/t->configured_voltage = cpu_to_le16(0);/t->configured_voltage = cpu_to_le16(1350);/g' hw/smbios/smbios.c
sed -i 's/t->location = 0x01;/t->location = 0x03;/g' hw/smbios/smbios.c
sed -i 's/t->error_correction = 0x06;/t->error_correction = 0x03;/g' hw/smbios/smbios.c
sed -i 's/"QEMU TCG CPU version/"TCG CPU version/g' target/i386/cpu.c
sed -i 's/"Microsoft Hv/"GenuineIntel/g' target/i386/cpu.c  #解决n卡vgpu驱动43问题
#sed -i 's/#define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x1af4/#define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x8086/g' include/hw/pci/pci.h # 0x1afe 是qemu虚拟机的id，这里为了兼容性只处理SUBVENDOR_ID。如果处理了VENDOR_ID=0x1af4 或者 VENDOR_ID=0x1b36 为其他值会造成一些设备无法使用。
#sed -i 's/#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x1af4/#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x8085/g' include/hw/pci/pci.h #如果处理了VENDOR_ID=0x1af4 或者 VENDOR_ID=0x1b36 为其他值会造成一些设备无法使用。比如scsi virtioNET virtioBlock不认
#sed -i 's/#define PCI_VENDOR_ID_REDHAT             0x1b36/#define PCI_VENDOR_ID_REDHAT             0x8085/g' include/hw/pci/pci.h #如果处理了VENDOR_ID=0x1af4 或者 VENDOR_ID=0x1b36 为其他值会造成一些设备无法使用。比如scsi virtioNET virtioBlock不认
sed -i 's/#define PCI_VENDOR_ID_QEMU               0x1234/#define PCI_VENDOR_ID_QEMU               0x8086 \/\/ "???" | Intel Device ID Replacement from 0x1234/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_INTEL_82801IR      0x2922/#define PCI_DEVICE_ID_INTEL_82801IR      0x463D \/\/ Intel 82801IR ICH9 - LPC Bridge [A2] | Intel Device ID Replacement from 0x2922 | hw\/ide\/ich.c/' include/hw/pci/pci.h
sed -i 's/#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x1af4/#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x8086 \/\/ Intel Vendor ID Replacement from 0x1af4/' include/hw/pci/pci.h
sed -i 's/#define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x1af4/#define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x8086 \/\/ Intel Subvendor ID Replacement from 0x1af4/' include/hw/pci/pci.h
sed -i 's/#define PCI_SUBDEVICE_ID_QEMU            0x1100/#define PCI_SUBDEVICE_ID_QEMU            0x8086 \/\/ Intel Subdevice ID Replacement from 0x1100/' include/hw/pci/pci.h
sed -i 's/#define PCI_VENDOR_ID_REDHAT             0x1b36/#define PCI_VENDOR_ID_REDHAT             0x8086 \/\/ "Red Hat, Inc." | Intel Vendor ID Replacement from 0x1b36/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001/#define PCI_DEVICE_ID_REDHAT_BRIDGE      0x4641 \/\/ "QEMU PCI-PCI bridge" | Intel Device ID Replacement from 0x0001 | hw\/pci-bridge\/pci_bridge_dev.c/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_REDHAT_PCIE_HOST   0x0008/#define PCI_DEVICE_ID_REDHAT_PCIE_HOST   0x4641 \/\/ "QEMU PCIe Host bridge" | Intel Device ID Replacement from 0x0008 | hw\/pci-host\/gpex.c/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c/#define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x51b0 \/\/ "QEMU PCIe Root Port" | Intel Device ID Replacement from 0x000c | hw\/pci-bridge\/gen_pcie_root_port.c/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_REDHAT_XHCI        0x000d/#define PCI_DEVICE_ID_REDHAT_XHCI        0x51ed \/\/ "QEMU XHCI Host Controller" | Intel Device ID Replacement from 0x000d | hw\/usb\/hcd-xhci-pci.c/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e/#define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x51b0 \/\/ "Red Hat, Device ID: 000E" | Intel Device ID Replacement from 0x000e | hw\/pci-bridge\/pcie_pci_bridge.c/' include/hw/pci/pci.h
sed -i 's/#define PCI_DEVICE_ID_INTEL_ICH9_6       0x2930/#define PCI_DEVICE_ID_INTEL_ICH9_6       0x51a3 \/\/ Type: System Device | Category: SMBus Controller | PCI Class: 0x0c05 | hw\/i2c\/smbus_ich9.c/' include/hw/pci/pci_ids.h
sed -i 's/#define PCI_DEVICE_ID_INTEL_ICH9_8       0x2918/#define PCI_DEVICE_ID_INTEL_ICH9_8       0x5182 \/\/ Type: Bridge Device | Category: LPC Controller   | PCI Class: 0x0601 | hw\/isa\/lpc_ich9.c/' include/hw/pci/pci_ids.h
sed -i 's/#define PCI_DEVICE_ID_INTEL_P35_MCH      0x29c0/#define PCI_DEVICE_ID_INTEL_P35_MCH      0x4641 \/\/ Type: Bridge Device | Category: Host Bridge | PCI Class: 0x0600 | hw\/pci-host\/q35.c/' include/hw/pci/pci_ids.h


sed -i 's/0x1af4/0x10EC/g' hw/audio/hda-codec.c # QEMU_HDA_ID_VENDOR  0x1af4 =ich9-intel-hda
sed -i 's/k->device_id = 0x2668;/k->device_id = 0x51c8;/' hw/audio/intel-hda.c
sed -i 's/k->revision = 1;/k->revision = 0;/' hw/audio/intel-hda.c
sed -i 's/k->device_id = 0x293e;/k->device_id = 0x51c8;/' hw/audio/intel-hda.c
sed -i 's/k->revision = 3;/k->revision = 0;/' hw/audio/intel-hda.c
sed -i 's/dc->hotpluggable = true;/dc->hotpluggable = false;/' hw/core/qdev.c

sed -i 's/rev = 3/rev = 4/g' hw/i386/acpi-build.c # Most VMs use an older-style FADT of length 244  bytes (revision  3), cutting off before the Sleep Control/Status registers and Hypervisor ID
sed -i 's/fadt.rev = 1/fadt.rev = 4/g' hw/i386/acpi-build.c # Most VMs use an older-style FADT of length 244  bytes (revision  3), cutting off before the Sleep Control/Status registers and Hypervisor ID
sed -i 's/if (f->rev <= 4) {/if (f->rev <= 6) {\n\t\tbuild_append_gas_from_struct(tbl, \&f->sleep_ctl);\n\t\tbuild_append_gas_from_struct(tbl, \&f->sleep_sts);/g' hw/acpi/aml-build.c # # Most VMs use an older-style FADT of length 244  bytes (revision  3), cutting off before the Sleep Control/Status registers and Hypervisor ID
sed -i 's/lat = 0xfff/lat = 0x1fff/g' hw/i386/acpi-build.c  # A value > 100 indicates the system does not support a C2/C3 state
sed -i 's/"WAET"/"WWWT"/g' hw/i386/acpi-build.c # "WAET" is also present as a string inside the WAET table, so there's no need to check for its table signature
sed -i 's/rev = 1/rev = 3/g' hw/i386/acpi-build.c # 全部升级最低为3

sed -i 's/dev = aml_device("PCI0");/aml_append(sb_scope, aml_name_decl("OSYS", aml_int(0x03E8)));\n\tAml *osi = aml_if(aml_equal(aml_call1("_OSI", aml_string("Windows 2012")), aml_int(1)));\n\taml_append(osi, aml_store(aml_int(0x07DC), aml_name("OSYS")));\n\taml_append(sb_scope, osi);\n\tosi = aml_if(aml_equal(aml_call1("_OSI",aml_string("Windows 2013")), aml_int(1)));\n\taml_append(osi, aml_store(aml_int(0x07DD), aml_name("OSYS")));\n\taml_append(sb_scope, osi);\n\taml_append(sb_scope, aml_name_decl("_TZ", aml_int(0x03E8)));\n\taml_append(sb_scope, aml_name_decl("_PTS", aml_int(0x03E8)));\n\tdev = aml_device("PCI0");/g' hw/i386/acpi-build.c # windows 2012 2013 _TZ_ _PTS dsdt
#sed -i 's/0x0627/0x6666/g' hw/input/virtio-input-hid.c # 0x0627=QEMU tablet usb键鼠会有少量问题
#sed -i 's/0x0627/0x6666/g' hw/usb/dev-hid.c # 0x0627=QEMU tablet usb键鼠会有少量问题
sed -i '/^[[:space:]]*fw_cfg_add_acpi_dsdt(sb_scope, x86ms->fw_cfg);$/d' hw/i386/acpi-microvm.c
sed -i '/^[[:space:]]*fw_cfg_add_acpi_dsdt(sb_scope, x86ms->fw_cfg);$/d' hw/i386/acpi-microvm.c
sed -i 's/aml_field("PCI0.SF8.PIRQ", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);/aml_field("PCI0.LPCB.PIRQ", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);/' hw/isa/lpc_ich9.c
sed -i 's/"QEMU"/"Logitech"/g; s/"QEMU USB Mouse"/"USB Mouse"/g; s/"QEMU USB Tablet"/"USB Tablet"/g; s/"QEMU USB Keyboard"/"USB Keyboard"/g; s/"42"/""/g; s/"89126"/""/g; s/"28754"/""/g; s/"68284"/""/g' hw/usb/dev-hid.c
# 设备描述符中的 Vendor/Product ID
sed -i 's/\.idVendor          = 0x0627,/.idVendor          = 0x046D,/; s/\.idProduct         = 0x0001,/.idProduct         = 0xC077,/; s/\.idProduct         = 0x0001,/.idProduct         = 0xC31C,/' hw/usb/dev-hid.c
# product_desc
sed -i 's/uc->product_desc   = "QEMU USB Tablet";/uc->product_desc   = "USB Tablet";/' hw/usb/dev-hid.c
sed -i 's/uc->product_desc   = "QEMU USB Mouse";/uc->product_desc   = "USB Mouse";/' hw/usb/dev-hid.c
sed -i 's/uc->product_desc   = "QEMU USB Keyboard";/uc->product_desc   = "USB Keyboard";/' hw/usb/dev-hid.c
echo "结束sed工作"

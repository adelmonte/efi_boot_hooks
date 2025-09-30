#!/bin/bash

# nvme0n1p2 partition (not filesystem) UUID
PARTUUID=""
# LUKS container
CRYPT_UUID=""

# Encryption and LUKS
CRYPT_OPTIONS="cryptdevice=UUID=${CRYPT_UUID}:luks-${CRYPT_UUID}:allow-discards,no-read-workqueue,no-write-workqueue rd.luks.options=discard rd.luks.uuid=${CRYPT_UUID}"

# General options
GENERAL_OPTIONS="rw quiet loglevel=0 systemd.show_status=false udev.log_priority=3 vt.global_cursor_default=0 nowatchdog"
# Enable old intel audio driver: snd-intel-dspcfg.dsp_driver=1

# Power management and ACPI
POWER_OPTIONS="pcie_aspm=force pcie_aspm.policy=powersupersave acpi_osi=! acpi_osi=\"Windows 2015\""
#POWER_OPTIONS="acpi.debug_level=0x2 acpi.debug_layer=0x0" (not working)

# Graphics and display
GRAPHICS_OPTIONS="drm.vblankoffdelay=1"

# zswap options
ZSWAP_OPTIONS="zswap.enabled=1 zswap.compressor=zstd zswap.max_pool_percent=90 zswap.zpool=zsmalloc zswap.same_filled_pages_enabled=1 zswap.max_compression_ratio=20"

# Hibernate
# resume=UUID= resume_offset= rootfstype=xfs

# booster initramfs
sudo /usr/lib/booster/regenerate_images

# Build the ukify EFI file
sudo ukify build \
--output=/boot/EFI/BOOT/BOOTX64.EFI \
--splash=/boot/reward-splash.bmp \
--linux=/boot/vmlinuz-linux-cachyos \
--microcode=/boot/intel-ucode.img \
--initrd=/boot/booster-linux-cachyos.img \
--cmdline="UUID=${PARTUUID} root=/dev/mapper/luks-${CRYPT_UUID} ${CRYPT_OPTIONS} ${GENERAL_OPTIONS} ${POWER_OPTIONS} ${GRAPHICS_OPTIONS} ${ZSWAP_OPTIONS}" \
&& sync

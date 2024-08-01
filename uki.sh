#!/bin/bash

# Root filesystem
ROOT_FS_UUID="UUID= "
ROOT_FS_DEVICE="/dev/mapper/luks"

# General options
GENERAL_OPTIONS="rw quiet loglevel=0 systemd.show_status=false udev.log_priority=3 vt.global_cursor_default=0"

# Watchdog settings
WATCHDOG_OPTIONS="nowatchdog watchdog=0 nmi_watchdog=0"

# Encryption and LUKS
CRYPT_OPTIONS="cryptdevice=UUID= :luks- :allow-discards,no-read-workqueue,no-write-workqueue rd.luks.options=discard rd.luks.uuid="

# Power management and ACPI
POWER_OPTIONS="pcie_aspm=force pcie_aspm.policy=powersupersave acpi_osi=\"Windows 2020\""

# Graphics and display
GRAPHICS_OPTIONS="drm.vblankoffdelay=1"

# Hibernate
#resume=UUID= resume_offset= rootfstype=ext4

# Booster Initramfs
sudo /usr/lib/booster/regenerate_images

# Move to the boot directory
cd /boot

# Build the ukify EFI file
sudo ukify build \
--output=ukify-booster.efi \
--linux=vmlinuz-linux \
--microcode=intel-ucode.img \
--initrd=booster-linux.img \
--cmdline="${ROOT_FS_UUID} root=${ROOT_FS_DEVICE} ${GENERAL_OPTIONS} ${WATCHDOG_OPTIONS} ${CRYPT_OPTIONS} ${POWER_OPTIONS} ${GRAPHICS_OPTIONS}"

cp -f /boot/ukify-booster.efi /boot/EFI/Linux/ukify-booster.efi



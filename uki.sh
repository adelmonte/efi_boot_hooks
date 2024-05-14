#!/bin/bash

sudo /usr/lib/booster/regenerate_images

# Move to the boot directory
cd /boot

# Build the ukify EFI file
sudo ukify build \
--output=ukify-booster.efi \
--linux=vmlinuz-linux \
--initrd=intel-ucode.img \
--initrd=booster-linux.img \
--cmdline="root=UUID=XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX rw quiet loglevel=0 systemd.show_status=false nowatchdog watchdog=0 nmi_watchdog=0 vt.global_cursor_default=0 cryptdevice=UUID=XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX:luks-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX:allow-discards,no-read-workqueue,no-write-workqueue root=/dev/mapper/luks-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX rd.luks.options=discard apparmor=1 security=apparmor udev.log_priority=3 vt.global_cursor_default=0 rd.luks.uuid=XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX  pcie_aspm=force pcie_aspm.policy=powersupersave acpi_osi=\"Windows 2020\" drm.vblankoffdelay=1 resume=UUID=XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX-XXXXXXXXXXXXX resume_offset=84209664 rootfstype=ext4"

# Copy EFI to Systemd-boot directory
cp -f /boot/ukify-booster.efi /boot/EFI/Linux/ukify-booster.efi

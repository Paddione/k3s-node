#!/bin/bash

# For VM 1000 and 100
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img

# Create VM 1000
qm create 1000 --memory 16000 --cores 4 --name ubuntu-k3s-template --net0 virtio,bridge=vmbr0

# Import the disk for VM 1000
qm importdisk 1000 jammy-server-cloudimg-amd64-disk-kvm.img local-lvm

# Configure VM 1000
qm set 1000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-1000-disk-0
qm set 1000 --ide2 local-lvm:cloudinit
qm set 1000 --boot c --bootdisk scsi0
qm set 1000 --serial0 socket --vga serial0

# Configure cloud-init for VM 1000
qm set 1000 --ciuser patrick
qm set 1000 --cipassword "170591pk"
qm set 1000 --sshkeys ~/.ssh/id_ed25519.pub

# Resize the disk for VM 1000
qm resize 1000 scsi0 32G

# Create the template for VM 1000
qm template 1000

# Create a new VM from template 1000
qm clone 1000 100 --name k3s-node1 --full

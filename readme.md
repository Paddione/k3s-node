#!/bin/bash

# For VM 1000 and 100
wget https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img

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

# For VM 2000 and 200
# Create VM 2000
qm create 2000 --memory 16000 --cores 4 --name ubuntu-k3s-template --net0 virtio,bridge=vmbr0

# Import the disk for VM 2000
qm importdisk 2000 jammy-server-cloudimg-amd64-disk-kvm.img local-lvm

# Configure VM 2000
qm set 2000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-2000-disk-0
qm set 2000 --ide2 local-lvm:cloudinit
qm set 2000 --boot c --bootdisk scsi0
qm set 2000 --serial0 socket --vga serial0

# Configure cloud-init for VM 2000
qm set 2000 --ciuser patrick
qm set 2000 --cipassword "170591pk"
qm set 2000 --sshkeys ~/.ssh/id_ed25519.pub

# Resize the disk for VM 2000
qm resize 2000 scsi0 32G

# Create the template for VM 2000
qm template 2000

# Create a new VM from template 2000
qm clone 2000 200 --name k3s-node1 --full

# For VM 3000 and 300
# Create VM 3000
qm create 3000 --memory 16000 --cores 4 --name ubuntu-k3s-template --net0 virtio,bridge=vmbr0

# Import the disk for VM 3000
qm importdisk 3000 jammy-server-cloudimg-amd64-disk-kvm.img local-lvm

# Configure VM 3000
qm set 3000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-3000-disk-0
qm set 3000 --ide2 local-lvm:cloudinit
qm set 3000 --boot c --bootdisk scsi0
qm set 3000 --serial0 socket --vga serial0

# Configure cloud-init for VM 3000
qm set 3000 --ciuser patrick
qm set 3000 --cipassword "170591pk"
qm set 3000 --sshkeys ~/.ssh/id_ed25519.pub

# Resize the disk for VM 3000
qm resize 3000 scsi0 32G

# Create the template for VM 3000
qm template 3000

# Create a new VM from template 3000
qm clone 3000 300 --name k3s-node1 --full

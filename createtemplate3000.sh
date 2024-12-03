# For VM 3000 and 300
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img
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

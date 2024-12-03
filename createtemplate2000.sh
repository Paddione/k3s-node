# For VM 2000 and 200
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img
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
qm clone 2000 200 --name k3s-node2 --full

# Create KVM VM using terraform

# Prerequite
Have to download terraform-provider-libvirt plugin at the following link.
* https://github.com/dmacvicar/terraform-provider-libvirt

have to copy the plugin file into .terraform.d/plugins at your home directory.

# Environment
Verified below versions
 - terraform 0.12.19
 - libvirtd 5.4.0
 - QEMU 4.0.0
 - terraform-provider-libvirt 0.6.1

# Recommended
It is better to use authentication with ssh-key.
If the using ssh-key, don't use the password.

# How to use
 0. should check and modify the variable.tf
 1. terraform init
 2. terraform plan
 3. terraform apply --auto-approve

resource "libvirt_volume" "emptyvol" {
  count = var.vm_count
  name = "empty_vol-${count.index}"
  size = 8589934592
}

resource "libvirt_network" "pubnet" {
  name = "pub-net"
  mode = "nat"
  bridge = "virbr7"
  addresses = ["${var.ext_addr}.0/24"]
  dns {
    enabled = true
    local_only = true
  }
}

resource "libvirt_network" "intnet" {
  name = "int-net"
  mode = "none"
  bridge = "virbr8"
  addresses = ["${var.int_addr}.0/24"]
  dns {
    enabled = true
    local_only = true
  }
  dhcp {
    enabled = true
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
  vars = {
    pubkey = var.ssh-pubkey
  }
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name = "cloudinit.iso"
  user_data = data.template_file.user_data.rendered
}

resource "libvirt_volume" "rootvol" {
  count = var.vm_count
  name = "root-vol-${count.index}"
  base_volume_pool = "default"
  pool = "disk0"
  format = "qcow2"
  source = "/var/lib/libvirt/images/centos7-cloud.qcow2"
}

resource "libvirt_domain" "instances" {
  count = var.vm_count

  name = "${var.vm_name}-${count.index}"
  memory = "4096"
  vcpu = 2
  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  disk {
    volume_id = libvirt_volume.rootvol[count.index].id
  }
  
  disk {
    volume_id = libvirt_volume.emptyvol[count.index].id
  }

  network_interface {
    network_id = libvirt_network.pubnet.id
    addresses  = ["${var.ext_addr}.10${count.index}"]
    wait_for_lease = true
  }

  network_interface {
    network_id = libvirt_network.intnet.id
    addresses  = ["${var.int_addr}.10${count.index}"]
    wait_for_lease = false
  }

  connection {
    type = "ssh"
    user = "root"
    password = "root123"
    #private_key = "${file("~/.ssh/id_rsa")}"
    host = "${var.ext_addr}.10${count.index}"
  }

  provisioner "remote-exec" {
    inline = [
      "yum install vim -y"
    ]
  }
}

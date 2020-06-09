output "instances_with_ipaddr" {
  description = "openstack instances with ipaddr"
  value = zipmap(libvirt_domain.instances.*.name, libvirt_domain.instances[*].network_interface.0.addresses.*)
}


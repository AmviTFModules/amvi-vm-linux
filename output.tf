output "vm_public_ip" {
  description = "Public IP address of the Linux VM."
  value       = azurerm_linux_virtual_machine.this.network_interface_ids[0]
}

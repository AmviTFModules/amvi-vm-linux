output "vm_public_ip" {
  description = "Public IP address of the Linux VM."
  value       = azurerm_linux_virtual_machine.example.network_interface_ids[0]
}

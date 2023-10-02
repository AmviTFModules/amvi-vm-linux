output "updated_resource_group_ids" {
  value = distinct(azurerm_resource_group.this.id)
}

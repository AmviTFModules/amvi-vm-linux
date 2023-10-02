data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "this" {
  count               = var.linux_vms.instance_count
  name                = format("%s-nic%s", var.vm_names[count.index], (var.linux_vms.start_index + count.index))
  location            = data.azurerm_virtual_network.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  depends_on            = [data.azurerm_resource_group.this, azurerm_network_interface.this]
  count                 = var.linux_vms.instance_count
  name                  = var.vm_names[count.index]
  location              = data.azurerm_virtual_network.this.location
  resource_group_name   = data.azurerm_resource_group.this.name
  tags                  = var.vm_tags
  size                  = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.this[count.index].id]

  dynamic "source_image_reference" {
    for_each = [var.linux_vms.image_reference]
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  /*admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }*/

  os_disk {
    caching              = var.linux_vms.os_disk.caching
    storage_account_type = var.linux_vms.os_disk.storage_account_type
    name                 = format("%s-osdisk%s", var.vm_names[count.index], (var.linux_vms.start_index + count.index))
  }

  computer_name  = "hostname"
  admin_username = var.username
}

# Path: variables.tf

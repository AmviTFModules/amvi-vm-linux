module "amvi-resource-group" {
  source = "github.com/AmviTFModules/amvi-resource-group"
  azure_resource_groups = {
    dev = {
      name     = "amvi-dev-rg"
      location = "East US"
      tags = {
        env = "dev"
      }
    }
    sit = {
      name     = "amvi-sit-rg"
      location = "East US 2"
      tags = {
        env = "sit"
      }
    }
  }
}





/*
  name        = each.value.name
  location    = each.value.location
  environment = each.value.environment
 */




/*
resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 2
  name                  = "${var.vmname}-amvi-${env}-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.test[count.index].id]
  size                  = "Standard_DS1_v2"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "myosdisk${count.index}"
  }

  computer_name  = "hostname"
  admin_username = var.username
}*/
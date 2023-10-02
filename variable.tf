# Purpose: Define variables

variable "vm_names" {
  type        = list(string)
  default     = []
  description = "The name of the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "vm_tags" {
  description = "Tags associated with virtual machines"
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "virtual_network_name" {
  description = "Virtual network where VM will reside"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
}

variable "linux_vms" {
  description = "Linux VMs"
  type = object({
    instance_count = number
    size           = string
    start_index    = number
    image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
  })
  default = {
    instance_count = 1
    size = "Standard_DS1_v2"
    start_index    = 1
    image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
  }
}

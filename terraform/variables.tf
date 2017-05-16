# Variables
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "resource_group" {
    default = "staging"
}

variable "location" {
  default = "westus2"
}

variable "image_uri" {
    description = "Windows version to boot"
    default = "MicrosoftWindowsServer:WindowsServer:2016-Datacenter:latest"
}

variable "address_space" {
  default = "10.0.0.0/16"
}

variable "subnet_prefix" {
  default = "10.0.1.0/24"
}

variable "storage_account_name" {
    default = "staging"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "vm_size" {
  default = "Standard_A0"
}

variable "hostname" {
    default = "staging01"
}

variable "admin_username" {
  description = "Remote VM admin username"
  default = "AKAzureAdmin"
}

variable "admin_password" {
  description = "Remote VM admin password"
}
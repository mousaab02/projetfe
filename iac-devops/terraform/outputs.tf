output "resource_group_name" {
  description = "Nom du groupe de ressources"
  value       = azurerm_resource_group.devops-rg.name
}

output "resource_group_location" {
  description = "Région du groupe de ressources"
  value       = azurerm_resource_group.devops-rg.location
}

output "public_ip_address" {
  description = "Adresse IP publique de la VM"
  value       = azurerm_public_ip.jenkins_vm_ip.ip_address
}

output "vm_name" {
  description = "Nom de la machine virtuelle"
  value       = azurerm_linux_virtual_machine.jenkins_vm.name
}

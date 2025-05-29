output "vm_public_ip" {
  value = azurerm_public_ip.vm.ip_address
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

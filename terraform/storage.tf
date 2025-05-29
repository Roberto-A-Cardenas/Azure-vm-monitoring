resource "azurerm_storage_account" "diag" {
  name                     = "diagstorage${random_id.rand.hex}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

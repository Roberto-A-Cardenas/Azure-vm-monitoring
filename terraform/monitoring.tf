resource "azurerm_log_analytics_workspace" "main" {
  name                = "log-analytics-monitoring"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "vm_diagnostics" {
  name                       = "vm-diagnostics"
  target_resource_id         = azurerm_linux_virtual_machine.vm2.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
      days    = 0
    }
  }

  # Removed unsupported `log` block
}

resource "azurerm_monitor_action_group" "email_alert" {
  name                = "ag-monitoring-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "alerts"

  email_receiver {
    name          = "email-alert"
    email_address = "ac42213@gmaail.com"
  }

  tags = {
    environment = "monitoring"
  }
}

resource "azurerm_monitor_metric_alert" "high_cpu" {
  name                = "High-CPU-Alert"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_virtual_machine.vm2.id]
  description         = "Triggers when CPU usage is above 70% for 5 minutes"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 70
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}

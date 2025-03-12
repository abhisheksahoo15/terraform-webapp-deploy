provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "resume_builder"
  location = "Central India"
}

resource "azurerm_app_service_plan" "app_plan" {
  name                = "resume-builder-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "ai-resume-builder"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  site_config {
    linux_fx_version = "PYTHON|3.12"
  }
}

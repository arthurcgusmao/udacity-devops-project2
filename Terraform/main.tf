provider "azurerm" {
  features {}
}

locals {
  name = "flask-ml-service-1933"
  location = "eastus2" # Cheaper

  tags = {
    app = "azure-devops-test"
    environment = "develop"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "${local.name}-rg"
  location = local.location
  tags = local.tags
}

resource "azurerm_app_service_plan" "this" {
  name                = "${local.name}-appserviceplan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind = "Linux"
  reserved = true
  tags = local.tags

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "this" {
  name                = "${local.name}-app-service"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id
  tags = local.tags

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    use_32_bit_worker_process = true # Required for free tier
    linux_fx_version = "PYTHON|3.6"
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
  }
}

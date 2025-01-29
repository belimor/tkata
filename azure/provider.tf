# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16.0"
    }
  }

  required_version = ">= 1.10.5"
}


# Use az account list to check azure subscription id
# export ARM_SUBSCRIPTION_ID="your-subscription-id"
provider "azurerm" {
  features {}

  # subscription_id = ""
  # subscription_id = var.subscription_id
}


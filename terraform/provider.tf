terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.0.20"
    }
  }
}

provider "civo" {
  token = var.token
}

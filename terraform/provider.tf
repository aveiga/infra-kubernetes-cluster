terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.0.20"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

provider "civo" {
  token = var.token
}

provider "local" {
  # Configuration options
}

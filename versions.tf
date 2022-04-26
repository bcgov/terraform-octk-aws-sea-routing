terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0.0"
    }
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.10.4"
    }
  }
}
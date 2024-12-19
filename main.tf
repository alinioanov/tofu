#———————————————————————————————————————————————————————————————————————————————————————————————————
variable "passphrase" {
  default = "DFjB2qs6JHinoPRLfh4N"
}

variable "state" {
  default = "tfstate.json"
}

#———————————————————————————————————————————————————————————————————————————————————————————————————
terraform {
  backend "local" {
    path = var.state
  }
  encryption {
    key_provider "pbkdf2" "this" {
      passphrase = var.passphrase
    }
    method "aes_gcm" "this" {
      keys = key_provider.pbkdf2.this
    }
    state {
      method   = method.aes_gcm.this
      enforced = true
    }
  }
}

#———————————————————————————————————————————————————————————————————————————————————————————————————
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}


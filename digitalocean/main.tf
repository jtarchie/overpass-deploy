terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

resource "digitalocean_ssh_key" "overpass_api_key" {
  name       = "overpass-api"
  public_key = file(var.ssh_public_key_path)
}

resource "digitalocean_droplet" "overpass_api_droplet" {
  name   = "overpass-api"
  size   = "s-1vcpu-1gb"
  image  = "docker-20-04"
  region = "nyc1"

  ssh_keys = [
    digitalocean_ssh_key.overpass_api_key.fingerprint
  ]
}

output "droplet_ip_address" {
  value       = digitalocean_droplet.overpass_api_droplet.ipv4_address
  description = "The IPv4 address of the Overpass API droplet"
}
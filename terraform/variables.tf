variable "sshkey_id" {
  description = "ssh key id for the stored ssh key of my dev laptop"
  type        = string
  sensitive   = true
}

variable "token" {
  description = "civo API token"
  type        = string
  sensitive   = true
}

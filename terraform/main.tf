# Query small instance size
data "civo_size" "large" {
  filter {
    key      = "name"
    values   = ["g3.large"]
    match_by = "re"
  }

  filter {
    key    = "type"
    values = ["instance"]
  }

}

# Query instance disk image
data "civo_disk_image" "ubuntu" {
  region = "LON1"
  filter {
    key    = "name"
    values = ["ubuntu-jammy"]
  }
}

# Create a new instance
resource "civo_instance" "server" {
  count      = 3
  region     = "LON1"
  size       = element(data.civo_size.large.sizes, 0).name
  disk_image = element(data.civo_disk_image.ubuntu.diskimages, 0).id
  sshkey_id  = var.sshkey_id
}

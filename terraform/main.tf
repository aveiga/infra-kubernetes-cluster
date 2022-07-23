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

# Create the first K8s Control Plane node
resource "civo_instance" "first_server" {
  region     = "LON1"
  size       = element(data.civo_size.large.sizes, 0).name
  disk_image = element(data.civo_disk_image.ubuntu.diskimages, 0).id
  sshkey_id  = var.sshkey_id
}

# Create the other K8s Control Plane node
resource "civo_instance" "other_servers" {
  count      = 1
  region     = "LON1"
  size       = element(data.civo_size.large.sizes, 0).name
  disk_image = element(data.civo_disk_image.ubuntu.diskimages, 0).id
  sshkey_id  = var.sshkey_id
}

resource "civo_instance" "workers" {
  count      = 1
  region     = "LON1"
  size       = element(data.civo_size.large.sizes, 0).name
  disk_image = element(data.civo_disk_image.ubuntu.diskimages, 0).id
  sshkey_id  = var.sshkey_id
}

# data "civo_instance" "server" {
#   name       = civo_instance.server.name
#   depends_on = [civo_instance.server]
# }

resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.tftpl",
    {
      first_server_ip  = civo_instance.first_server.public_ip,
      other_servers_ip = civo_instance.other_servers.*.public_ip
      workers_ip       = civo_instance.workers.*.public_ip
    }
  )
  filename = "../ansible/hosts.yaml"
}

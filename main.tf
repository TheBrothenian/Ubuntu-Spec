terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16"
    }
  }



  required_version = ">= 1.0"  
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:20.04"
}

resource "docker_container" "ubuntu_ansible" {
  image = docker_image.ubuntu.image_id
  name  = "ubuntu_ansible_container"
  ports {
    internal = 22
    external = 2222
  }
  tty = true
  stdin_open = true

  provisioner "local-exec" {
    command = "sleep 10 && ansible-playbook -i 'localhost:2222,' -u root --private-key ~/.ssh/id_rsa playbook.yml"
  }
}


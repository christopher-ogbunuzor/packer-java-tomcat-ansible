# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# See https://www.packer.io/docs/templates/hcl_templates/blocks/packer for more info
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "ami_name" {
  type    = string
  default = "tomcat-ami"
}

locals {
  packerstarttime = formatdate("YYYY-MM-DD-hhmm", timestamp())
  # Also here I believe naming this variable `buildtime` could lead to 
  # confusion mainly because this is evaluated a 'parsing-time'.
}

// variable "aws_access_key" {
//   type    = string
//   default = ""
// }

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

// variable "aws_secret_key" {
//   type    = string
//   default = ""
// }

variable "ssh_username" {
  type    = string
  default = "centos"
}

// variable "subnet_id" {
//   type    = string
//   default = ""
// }

// variable "vpc_id" {
//   type    = string
//   default = ""
// }

# The amazon-ami data block is generated from your amazon builder source_ami_filter; a data
# from this block can be referenced in source and locals blocks.
# Read the documentation for data blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/data
# Read the documentation for the Amazon AMI Data Source here:
# https://www.packer.io/plugins/datasources/amazon/ami
data "amazon-ami" "autogenerated_1" {
  // access_key = "${var.aws_access_key}"
  filters = {
    name                = "CentOS Linux 7 x86_64 HVM EBS *"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["461800378586"]
  region      = "${var.aws_region}"
  // secret_key  = "${var.aws_secret_key}"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "amazon-ebs" "autogenerated_1" {
  // access_key                  = "${var.aws_access_key}"
  ami_name                    = "${var.ami_name}-${local.packerstarttime}"
  associate_public_ip_address = true
  communicator                = "ssh"
  force_deregister            = "true"
  instance_type               = "t2.micro"
  region                      = "${var.aws_region}"
  run_tags = {
    Name = "packer-build-image"
  }
  // secret_key   = "${var.aws_secret_key}"
  source_ami   = "${data.amazon-ami.autogenerated_1.id}"
  ssh_username = "${var.ssh_username}"
  // subnet_id    = "${var.subnet_id}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "shell" {
    inline = "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"
  }

  provisioner "shell" {
    script = "./provisioners/scripts/bootstrap.sh"
  }

  provisioner "ansible" {
    playbook_file = "./provisioners/ansible/setup-server.yml"
  }

  provisioner "ansible" {
    playbook_file = "./provisioners/ansible/deploy_app.yml"
  }

}

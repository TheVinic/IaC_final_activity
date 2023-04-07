variable "instance_frontend"{
    description = "Number of Public instances"
    default = 5
}

variable "instance_backend"{
    description = "Number of backend instances"
    default = 5
}

variable "subnet_public_quantity"{
    description = "Public subnet quantity"
    default = 3
}

variable "key_name"{
    description = "Public key"
    default = "terraform"
}

variable "subnet_private_amount"{
    description = "Private subnet quantity"
    default = 3
}

variable "image_amazon"{
    description = "amazon image"
    default = "ami-04581fbf744a7d11f"
}


variable "image_ubuntu"{
    description = "ubuntu image"
    default = "ami-0557a15b87f6559cf"
}

variable "project" {
  description = "Project name"
  default     = "Exercise3"
}
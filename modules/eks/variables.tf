variable "aws_region" {
  default = "eu-west-1"
}


variable "environment_name" {
  default = " "
}

variable "project_name" {
  #default = " "
}

variable "cluster_name" {
  default = " "
}

variable "vpc_id" {
  type = string
}


variable "subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}


variable "cluster_version" {
  default = " "
}

variable "enabled_cluster_log_types" {
  type = list(string)
}

variable "cluster_endpoint_public_access" {
  default = " "
}
variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      version = "v1.24.15-eksbuild.1"
    },
    {
      name    = "vpc-cni"
      version = "v1.13.2-eksbuild.1"
    },
    {
      name    = "coredns"
      version = "v1.9.3-eksbuild.5"
    },
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.20.0-eksbuild.1"
    }
  ]
}
variable "on_demand_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}
variable "spot_instance_types" {
  type    = list(string)
  default = ["t3.large"]
}
variable "create_on_demand_ng" {
  type    = bool
  default = true
}
variable "create_spot_ng" {
  type    = bool
  default = false
}
variable "eks_spot_min_size" {
  type    = number
  default = 1

}
variable "eks_spot_max_size" {
  type    = number
  default = 1

}
variable "eks_spot_desired_size" {
  type    = number
  default = 1

}

variable "eks_on_demand_min_size" {
  type    = number
  default = 1

}
variable "eks_on_demand_max_size" {
  type    = number
  default = 1

}
variable "eks_on_demand_desired_size" {
  type    = number
  default = 1

}
variable "aws_profile_name" {
  type    = string
  default = "default"

}
variable "enable_cluster_autoscaler" {
  type    = bool
  default = false

}


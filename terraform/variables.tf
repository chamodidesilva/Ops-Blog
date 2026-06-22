# variable "allowed_ips" {
#   type        = string
#   description = "Restrict ECS task access in security group only to my IP for testing"
# }

variable "flask_secret_value" {
  type        = string
  description = "Value for the FLASK_SECRET"
}

variable "ecr_image_tag" {
  type        = string
  description = "Tag for the ECR image"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "acc_id" {
  type        = string
  description = "AWS account ID"
}

variable "subnet_az" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "subnet_az_2" {
  type        = string
  description = "Availability zone for the second subnet"
}

# variable "cert_arn" {
#   type        = string
#   description = "ARN for public SSL certificate"
# }

variable "environment_active" {
  type    = bool
  default = true
}


terraform {
  backend "s3" {
    bucket         = "ops-blog-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}


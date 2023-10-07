terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.0"
    }
  }

  backend "s3" {
    bucket = "website-blog-terraform"
    key    = "state/main"
    region = "eu-central-1"
  }
}


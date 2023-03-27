/// main.tf is the entry point containing terraform configurations 

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }

    required_version = ">= 1.4.2"
}

# Deploying to unused region in my sandbox account. 
provider "aws" {
    region = "us-west-1"
}

locals {
    tags = {
        cloudlab = ""
    }
}

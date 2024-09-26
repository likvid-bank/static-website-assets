terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58.0"
    }
  }
  backend "s3" {
    bucket  = "likvid-static-website-assets-terraform-state"
    key     = "tfstate"
    region  = "eu-central-1"
    profile = "m25-platform"
  }
}

provider "aws" {
  alias               = "m25"
  region              = "eu-central-1"
  profile             = "m25-platform"
  allowed_account_ids = ["060795938541"]
  default_tags {
    tags = {
      "SourceRepo" = "https://github.com/likvid-bank/static-website-assets"
    }
  }
}

provider "aws" {
  alias               = "root"
  region              = "eu-central-1"
  profile             = "meshcloud-dev-root"
  allowed_account_ids = ["702461728527"]
  default_tags {
    tags = {
      "SourceRepo" = "https://github.com/mlikvid-bank/static-website-assets"
    }
  }
}

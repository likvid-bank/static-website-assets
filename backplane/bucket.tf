resource "aws_s3_bucket" "terraform_state" {
  provider = aws.m25
  bucket   = var.bucket_name 
}

## user to access bucket only (used for buildingblock backend)
# The iam-user is created over the buildingBlock

data "aws_iam_user" "buildingblock_tfstate" {
  provider = aws.m25
  user_name     = var.iam_user_name_buildingblock 
}

resource "aws_iam_access_key" "buildingblock_tfstate" {
  provider = aws.m25
  user     = data.aws_iam_user.buildingblock_tfstate.user_name
}

resource "aws_iam_user_policy" "buildingblock_tfstate" {
  provider = aws.m25
  name     = "terraform-state-bucket-policy"
  user     = data.aws_iam_user.buildingblock_tfstate.user_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          aws_s3_bucket.terraform_state.arn,
          "${aws_s3_bucket.terraform_state.arn}/*"
        ]
      }
    ]
  })
}

resource "local_file" "backend" {
  filename = "${path.module}/.backend.tf"
  content  = <<EOF
terraform {
  backend "s3" {
    bucket         = "${aws_s3_bucket.terraform_state.id}"
    key            = "buildingblocks.tfstate"
    region         = "${aws_s3_bucket.terraform_state.region}"
    access_key     = "${aws_iam_access_key.buildingblock_tfstate.id}"
    secret_key     = "${aws_iam_access_key.buildingblock_tfstate.secret}"
  }
}
EOF
}

output "backend_tf" {
  value = "Use generated `.backend.tf` as encrypted static input of type FILE to configure backend for the buildingblock."
}

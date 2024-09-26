# IAM user that will be used by GH action (https://github.com/meshcloud/static-website-assets/settings/secrets/actions)
# The iam-user is created over the buildingBlock 
data "aws_iam_user" "gh_action" {
  provider = aws.m25
  user_name = var.iam_user_name_ghaction
}

resource "aws_iam_access_key" "gh_action" {
  provider = aws.m25
  user     = data.aws_iam_user.gh_action.user_name
}

output "aws_iam_access_key" {
  value = aws_iam_access_key.gh_action.id
}

output "aws_iam_secret_key" {
  sensitive = true
  value     = aws_iam_access_key.gh_action.secret
}

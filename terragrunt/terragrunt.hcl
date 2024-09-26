terraform {
  source = "${get_repo_root()}//backplane"
}

locals {
  prefix = "likvid-static-website-assets"
}

inputs = {
  bucket_name = "${local.prefix}-terraform-state"
  iam_policy_name = "${local.prefix}-ghaction-sso-policy"
  iam_user_name_ghaction = "${local.prefix}-ghaction"
  iam_role_name = "${local.prefix}-github-action-role"
  iam_user_name_buildingblock = "${local.prefix}-buildingblock-tfstate"
}

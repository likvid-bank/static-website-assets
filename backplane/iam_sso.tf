resource "aws_iam_policy" "sso_policy" {
  provider = aws.root
  name     = var.iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sso:CreatePermissionSet",
          "sso:DeletePermissionSet",
          "sso:DescribePermissionSet",
          "sso:ListPermissionSets",
          "sso:ListPermissionSetsProvisionedToAccount",
          "sso:ProvisionPermissionSet",
          "sso:PutPermissionsBoundaryToPermissionSet",
          "sso:UpdatePermissionSet",
          "sso:CreateAccountAssignment",
          "sso:DeleteAccountAssignment",
          "sso:DescribeAccountAssignmentCreationStatus",
          "sso:DescribeAccountAssignmentDeletionStatus",
          "sso:ListAccountAssignments",
          "sso:PutInlinePolicyToPermissionSet",
          "identitystore:ListUsers"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "gh_action_role" {
  provider = aws.root
  name     = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = data.aws_iam_user.gh_action.arn
        },
        Action = ["sts:AssumeRole", "sts:TagSession"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sso_policy_attachment" {
  provider   = aws.root
  role       = aws_iam_role.gh_action_role.name
  policy_arn = aws_iam_policy.sso_policy.arn
}

resource "aws_iam_policy" "assume_github_action_role_in_root_account" {
  provider = aws.m25
  name     = "assume-github-action-role-in-root-account"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["sts:AssumeRole", "sts:TagSession"],
        Resource = aws_iam_role.gh_action_role.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "assume_github_action_role_in_root_account" {
  provider   = aws.m25
  user       = data.aws_iam_user.gh_action.user_name
  policy_arn = aws_iam_policy.assume_github_action_role_in_root_account.arn
}

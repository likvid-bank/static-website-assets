resource "aws_iam_policy" "s3_policy" {
  provider = aws.m25
  name     = "gh-action-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "cloudformation_policy" {
  provider = aws.m25
  name     = "gh-action-cloudformation-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudformation:CreateStack",
          "cloudformation:UpdateStack",
          "cloudformation:DeleteStack",
          "cloudformation:DescribeStacks",
          "cloudformation:CreateChangeSet",
          "cloudformation:DescribeChangeSet",
          "cloudformation:DeleteChangeSet"

        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3_attachment" {
  provider   = aws.m25
  user       = data.aws_iam_user.gh_action.user_name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_user_policy_attachment" "cloudformation_attachment" {
  provider   = aws.m25
  user       = data.aws_iam_user.gh_action.user_name
  policy_arn = aws_iam_policy.cloudformation_policy.arn
}

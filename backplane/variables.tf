variable "iam_user_name_ghaction" {
  description = "Name of the IAM user that will be used by gh-action"
  type        = string
  default     = "gh-action" 
}

variable "iam_user_name_buildingblock" {
  description = "Name of the IAM user that will be used by gh-action"
  type        = string
  default     = "buildingblocks-tfstate"
}

variable "iam_policy_name" {
  description = "Name of the IAM policy that will be used by gh-action"
  type        = string
  default     = "gh-action-sso-policy" 
}

variable "iam_role_name" {
  description = "Name of the IAM role that will be used by gh-action"
  type        = string
  default     = "github-action-role" 
}

variable "bucket_name" {
  description = "Name of the bucket that will be used by gh-action"
  type        = string
  default     = "terraform-state-bucket" 
}

# Configure the AWS provider
provider "aws" {
  region = "us-west-2"  # Specify your desired region
}

# Create an IAM group
resource "aws_iam_group" "my_group" {
  name = "my-group"
}

# Create an IAM user
resource "aws_iam_user" "my_user" {
  name = "my-user"
}
resource "aws_iam_user_group_membership" "example2" {
  user = aws_iam_user.my_user.name

  groups = [
    aws_iam_group.my_group.name
  ]
}

# Add the user to the group
resource "aws_iam_group_membership" "my_membership" {
  name    = aws_iam_group.my_group.name
  users   = [aws_iam_user.my_user.name]
}

# Create an IAM policy
resource "aws_iam_policy" "my_policy" {
  name        = "my-policy"
  description = "My custom policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the policy to the group
resource "aws_iam_group_policy_attachment" "my_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = aws_iam_policy.my_policy.arn
}

# Create an IAM role
resource "aws_iam_role" "my_role" {
  name               = "my-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

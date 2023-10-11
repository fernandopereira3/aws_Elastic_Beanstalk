# CRIA POLICA E REGRAS DO BEAN STALK
resource "aws_iam_role" "beanstalk_ec2" {
  name = "beanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# CRIA POLICA E REGRAS DO BEAN STALK
resource "aws_iam_role_policy" "beanstalk_ec2_policy" {
  name = "beanstalk_ec2_policy"
  role = aws_iam_role.beanstalk_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudwatch:PutMetricData",
          "ds:CreateComputer",
          "ds:DescribeInstanceStatus",
          "logs:*",
          "ssm:*",
          "ec2messages:*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# CRIA PROFILE DO BEAN STALK
resource "aws_iam_instance_profile" "beanstalk_ec2_profile" {
  name = "beanstalk_ec2_profile"
  role = aws_iam_role.beanstalk_ec2.name
}
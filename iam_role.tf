resource "aws_iam_role" "appsync_graphql_dynamodb_tenants" {
  name = "appsync_graphql_dynamodb_tenants"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "appsync_graphql_dynamodb_tenants_policy" {
  name = "appsync_graphql_dynamodb_tenants_policy"
  role = "${aws_iam_role.appsync_graphql_dynamodb_tenants.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_dynamodb_table.tenants.arn}"
      ]
    }
  ]
}
EOF
}

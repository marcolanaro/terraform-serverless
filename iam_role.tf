resource "aws_iam_role" "appsync_graphql" {
  name = "appsync_graphql"

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

resource "aws_iam_role_policy" "appsync_graphql_policy" {
  name = "appsync_graphql_policy"
  role = "${aws_iam_role.appsync_graphql.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*",
        "lambda:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_dynamodb_table.tenants.arn}",
        "${aws_lambda_function.approve_tenant.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "appsync_graphql_dynamodb_list" {
  name = "appsync_graphql_dynamodb_list"

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

resource "aws_iam_role_policy" "appsync_graphql_dynamodb_list_policy" {
  name = "appsync_graphql_dynamodb_list_policy"
  role = "${aws_iam_role.appsync_graphql_dynamodb_list.id}"

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
        "${aws_dynamodb_table.list.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda" {
  name = "lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip_approveTenant" {
  type        = "zip"
  source_dir  = "./lambda/approveTenant"
  output_path = "./lambda/zip/lambda_approveTenant.zip"
}

resource "aws_lambda_function" "approve_tenant" {
  function_name    = "approveTenant"
  handler          = "main.handler"
  runtime          = "nodejs8.10"
  role             = "${aws_iam_role.lambda.arn}"
  filename         = "./lambda/zip/lambda_approveTenant.zip"
  source_code_hash = "${data.archive_file.lambda_zip_approveTenant.output_base64sha256}"
}

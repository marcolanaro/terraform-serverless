resource "aws_cognito_user_pool" "main" {
  name                     = "mainPool"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = "8"
    require_numbers   = true
    require_lowercase = true
    require_uppercase = true
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "main-pool-domain"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
}

resource "aws_cognito_user_pool_client" "client" {
  name                         = "client"
  user_pool_id                 = "${aws_cognito_user_pool.main.id}"
  generate_secret              = false
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows          = ["implicit"]
  allowed_oauth_scopes         = ["email", "openid", "profile", "aws.cognito.signin.user.admin"]
  callback_urls                = ["http://localhost"]
  logout_urls                  = ["http://localhost"]
}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "main identity pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = "${aws_cognito_user_pool_client.client.id}"
    provider_name           = "cognito-idp.eu-west-1.amazonaws.com/${aws_cognito_user_pool.main.id}"
    server_side_token_check = false
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = "${aws_cognito_identity_pool.main.id}"

  roles {
    "authenticated" = "${aws_iam_role.authenticated.arn}"
  }
}

resource "aws_iam_role" "authenticated" {
  name = "cognito_authenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.main.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "authenticated" {
  name = "authenticated_policy"
  role = "${aws_iam_role.authenticated.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

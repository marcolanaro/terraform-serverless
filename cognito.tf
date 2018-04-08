provider "aws" {
  region = "eu-central-1"
}

resource "aws_cognito_user_pool" "main" {
  name = "mainPool"
  username_attributes = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length = "8"
    require_numbers = true
    require_lowercase = true
    require_uppercase = true
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain = "main-pool-domain"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
  generate_secret = false
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows = ["implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile", "aws.cognito.signin.user.admin"]
  callback_urls = ["http://localhost"]
  logout_urls = ["http://localhost"]
}

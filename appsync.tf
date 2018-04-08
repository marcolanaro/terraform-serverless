resource "aws_appsync_graphql_api" "graphql" {
  name                = "graphql"
  authentication_type = "AMAZON_COGNITO_USER_POOLS"

  user_pool_config {
    aws_region          = "eu-west-1"
    default_action      = "ALLOW"
    user_pool_id        = "${aws_cognito_user_pool.main.id}"
    app_id_client_regex = "${aws_cognito_user_pool_client.client.id}"
  }
}

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

resource "aws_appsync_datasource" "tenants" {
  api_id           = "${aws_appsync_graphql_api.graphql.id}"
  name             = "tenants"
  type             = "AMAZON_DYNAMODB"
  service_role_arn = "${aws_iam_role.appsync_graphql_dynamodb_tenants.arn}"

  dynamodb_config {
    region     = "eu-west-1"
    table_name = "${aws_dynamodb_table.tenants.name}"
  }
}

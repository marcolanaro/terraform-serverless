resource "aws_dynamodb_table" "tenants" {
  name           = "tenants"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

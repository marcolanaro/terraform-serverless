# terraform-serverless
Configure AWS serverless infrastructure

## Install

`mv ~/Downloads/terraform /usr/local/bin/`

`source ~/.profile`

## AWS Credentials

Create `~/.aws/credentials`, it should contains:

    [default]
    aws_access_key_id=
    aws_secret_access_key=

## CLI

`terraform init`

`terraform apply`

`terraform show`

`terraform destroy`

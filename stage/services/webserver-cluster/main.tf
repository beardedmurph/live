provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state20200826a"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "eu-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "webserver_cluster" {
  source = "github.com/beardedmurph/modules//services/webserver-cluster?ref=v0.0.4"

  cluster_name = "webservers-stage"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}
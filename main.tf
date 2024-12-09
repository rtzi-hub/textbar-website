provider "aws" {
  region = var.region
}

module "s3_website" {
  source          = "./Modules/s3"
  bucket_name     = var.bucket_name
  api_gateway_url = module.api_gateway.api_gateway_url
}

module "dynamodb" {
  source     = "./Modules/dynamodb"
  table_name = var.table_name
}

module "lambda" {
  source     = "./Modules/lambda"
  table_name = module.dynamodb.table_name
}

module "api_gateway" {
  source            = "./Modules/api_gateway"
  region            = var.region
  submit_lambda_arn = module.lambda.submit_lambda_arn
  fetch_lambda_arn  = module.lambda.fetch_lambda_arn
}

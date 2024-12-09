resource "aws_api_gateway_rest_api" "textbar_api" {
  name        = "TextBarAPI1"
  description = "API Gateway for TextBar application"
}

resource "aws_api_gateway_resource" "entries_resource" {
  rest_api_id = aws_api_gateway_rest_api.textbar_api.id
  parent_id   = aws_api_gateway_rest_api.textbar_api.root_resource_id
  path_part   = "entries"
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.textbar_api.id
  resource_id   = aws_api_gateway_resource.entries_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.textbar_api.id
  resource_id             = aws_api_gateway_resource.entries_resource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.submit_lambda_arn}/invocations"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.textbar_api.id
  resource_id   = aws_api_gateway_resource.entries_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.textbar_api.id
  resource_id             = aws_api_gateway_resource.entries_resource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.fetch_lambda_arn}/invocations"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_integration.get_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.textbar_api.id
  description = "Deployment for TextBar API"
}

resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.textbar_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id

  variables = {
    environment = "production"
  }
}

output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.textbar_api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.prod_stage.stage_name}/entries"
}

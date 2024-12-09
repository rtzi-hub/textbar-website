variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "submit_lambda_arn" {
  description = "ARN of the Submit Lambda function"
  type        = string
}

variable "fetch_lambda_arn" {
  description = "ARN of the Fetch Lambda function"
  type        = string
}

variable "region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for website hosting"
  type        = string
  default     = "textbar-website1"
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "dynamodbtable"
}

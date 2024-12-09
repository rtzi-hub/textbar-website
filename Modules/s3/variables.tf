variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "api_gateway_url" {
  description = "The API Gateway URL for the backend"
  type        = string
}

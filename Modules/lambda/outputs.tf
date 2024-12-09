output "submit_lambda_arn" {
  value = aws_lambda_function.submit.arn
}

output "fetch_lambda_arn" {
  value = aws_lambda_function.fetch.arn
}

# Archive the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_func"
  output_path = "${path.module}/lambda_func.zip"
}

# Lambda function for fetching entries
resource "aws_lambda_function" "fetch" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "FetchEntriesFunction1"
  handler       = "fetchEntries.lambda_handler"
  runtime       = "python3.13"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}

# Lambda function for submitting entries
resource "aws_lambda_function" "submit" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "SubmitEntriesFunction1"
  handler       = "submitEntries.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}

# IAM Role for Lambda functions
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_cloudwatch_log_group" "fetch_logs" {
  name              = "/aws/lambda/${aws_lambda_function.fetch.function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "submit_logs" {
  name              = "/aws/lambda/${aws_lambda_function.submit.function_name}"
  retention_in_days = 7
}



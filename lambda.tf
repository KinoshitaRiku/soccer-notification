resource "aws_lambda_function" "soccer" {
  filename      = data.archive_file.function_source.output_path
  function_name = "soccer-notification"
  role          = var.lambda_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 10
}

data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "lambda"
  output_path = "archive/lambda_function.zip"
}

# resource "aws_lambda_permission" "soccer" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   # function_name = "${aws_lambda_function.lambda_function.lambda_handler}"
#   function_name = "soccer-notification"
#   principal     = "events.amazonaws.com"
#   # source_arn    = "${aws_cloudwatch_event_rule.soccer.arn}"
#   source_arn = ""
# }
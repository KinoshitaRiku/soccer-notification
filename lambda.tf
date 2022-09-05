resource "aws_lambda_function" "soccer" {
  filename      = "lambda_function.zip"
  function_name = "lambda_handler"
  role          = "arn:aws:iam::452199140935:role/lambda-cloudformation-dri-CloudFormationDriftLambd-1X754ATUFUGEY"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 10
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
resource "aws_cloudwatch_event_rule" "soccer" {
  name                = "soccer-notification"
  description         = "マンシーの通知を18時に行う"
  schedule_expression = "cron(0 18 * * ? *)"
}

resource "aws_cloudwatch_event_target" "soccer" {
  rule = "${aws_cloudwatch_event_rule.soccer.name}"
  arn  = "${aws_lambda_function.soccer.arn}"
}
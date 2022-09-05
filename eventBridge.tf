resource "aws_cloudwatch_event_rule" "soccer" {
  name                = "soccer-notification"
  description         = "マンチェスター・シティの試合があるか18時に通知"
  schedule_expression = "cron(0 9 * * ? *)"
}

resource "aws_cloudwatch_event_target" "soccer" {
  rule = "${aws_cloudwatch_event_rule.soccer.name}"
  arn  = "${aws_lambda_function.soccer.arn}"
}
#############################################
# CloudWatch Metric Alarm
#############################################

resource "aws_cloudwatch_metric_alarm" "this" {

  ###########################################
  # Alarm Details
  ###########################################

  alarm_name        = var.alarm_name
  alarm_description = var.alarm_description

  ###########################################
  # Metric Configuration
  ###########################################

  namespace   = var.namespace
  metric_name = var.metric_name
  statistic   = var.statistic
  period      = var.period

  ###########################################
  # Alarm Behaviour
  ###########################################

  comparison_operator = var.comparison_operator
  threshold           = var.threshold
  evaluation_periods  = var.evaluation_periods

  ###########################################
  # Metric Dimensions
  ###########################################

  dimensions = var.dimensions

  ###########################################
  # Missing Data Handling
  ###########################################

  treat_missing_data = var.treat_missing_data

  ###########################################
  # Alarm Actions
  ###########################################

  alarm_actions = var.alarm_actions
}
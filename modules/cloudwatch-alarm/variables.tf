#############################################
# Alarm Configuration
#############################################

variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
}

variable "alarm_description" {
  description = "Description of the alarm"
  type        = string
  default     = ""
}

#############################################
# Metric Configuration
#############################################

variable "namespace" {
  description = "CloudWatch metric namespace"
  type        = string
}

variable "metric_name" {
  description = "Name of the CloudWatch metric"
  type        = string
}

variable "statistic" {
  description = "Statistic to monitor"
  type        = string
  default     = "Average"
}

variable "period" {
  description = "Metric evaluation period in seconds"
  type        = number
  default     = 300
}

#############################################
# Alarm Threshold
#############################################

variable "comparison_operator" {
  description = "Comparison operator for the alarm"
  type        = string
}

variable "threshold" {
  description = "Threshold for triggering the alarm"
  type        = number
}

variable "evaluation_periods" {
  description = "Number of periods before alarm triggers"
  type        = number
  default     = 2
}

#############################################
# Dimensions
#############################################

variable "dimensions" {
  description = "Metric dimensions"
  type        = map(string)
}

#############################################
# Missing Data Behaviour
#############################################

variable "treat_missing_data" {
  description = "How CloudWatch treats missing data"
  type        = string
  default     = "missing"
}

#############################################
# Alarm Actions
#############################################

variable "alarm_actions" {
  description = "Actions to execute when the alarm enters the ALARM state"
  type        = list(string)
  default     = []
}
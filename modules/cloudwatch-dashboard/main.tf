
data "aws_caller_identity" "current" {}
#############################################
# CloudWatch Dashboard
#############################################

resource "aws_cloudwatch_dashboard" "this" {

  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({

    widgets = [

      #########################################
      # CPU Utilization Widget
      #########################################

      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {

          title   = "EC2 CPU Utilization"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          stat    = "Average"
          period  = 300

          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              var.instance_id
            ]
          ]

        }
      },

      #########################################
      # Memory Utilization Widget
      #########################################

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title   = "Memory Utilization"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          stat    = "Average"
          period  = 300

          metrics = [
            [
              "TerraformBootcamp",
              "mem_used_percent",
              "InstanceId",
              var.instance_id
            ]
          ]
        }
      },

      #########################################
      # Disk Utilization Widget
      #########################################

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title   = "Disk Utilization"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          stat    = "Average"
          period  = 300

          metrics = [
            [
              "TerraformBootcamp",
              "disk_used_percent",
              "path",
              "/",
              "InstanceId",
              var.instance_id
            ]
          ]
        }
      },

      #########################################
      # Network in Widget
      #########################################
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title   = "Network In"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          stat    = "Sum"
          period  = 300

          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "InstanceId",
              var.instance_id
            ]
          ]
        }
      },
      #########################################
      # Network out Widget
      #########################################

      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          title   = "Network Out"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          stat    = "Sum"
          period  = 300

          metrics = [
            [
              "AWS/EC2",
              "NetworkOut",
              "InstanceId",
              var.instance_id
            ]
          ]
        }
      },

      #########################################
      # Alarm Status Widget
      #########################################
      {
        type   = "alarm"
        x      = 12
        y      = 12
        width  = 12
        height = 6

        properties = {
          title = "CloudWatch Alarms"

          alarms = [
            "arn:aws:cloudwatch:${var.aws_region}:${data.aws_caller_identity.current.account_id}:alarm:${var.cpu_alarm_name}"
          ]
        }
      }

    ]

  })
}
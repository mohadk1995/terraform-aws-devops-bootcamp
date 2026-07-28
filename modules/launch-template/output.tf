##############################################
# Launch Template Outputs
##############################################

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.this.id
}

output "launch_template_name" {
  description = "Launch Template Name"
  value       = aws_launch_template.this.name
}

output "latest_version" {
  description = "Latest Launch Template Version"
  value       = aws_launch_template.this.latest_version
}
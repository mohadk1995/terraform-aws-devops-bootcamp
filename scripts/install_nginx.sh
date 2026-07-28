#!/bin/bash

exec > /var/log/user-data.log 2>&1

echo "Starting bootstrap..."

#############################################################
# Update installed packages
#############################################################
dnf update -y

#############################################################
# Install Nginx
#############################################################
dnf install nginx -y

systemctl enable nginx
systemctl start nginx

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Terraform Bootcamp</title>
</head>
<body>
<h1>Terraform + AWS + Nginx</h1>
<h2>Created by Mohammed</h2>
</body>
</html>
EOF

#############################################################
# Install CloudWatch Agent
#############################################################

dnf install amazon-cloudwatch-agent -y

#############################################################
# Create Configuration Directory
#############################################################

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc

#############################################################
# Write Configuration
#############################################################

cat <<'EOF' > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
${cloudwatch_config}
EOF

#############################################################
# Enable Service
#############################################################

systemctl enable amazon-cloudwatch-agent

#############################################################
# Start Service
#############################################################

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
-s



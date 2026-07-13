#!/bin/bash

exec > /var/log/user-data.log 2>&1

echo "Starting bootstrap..."

amazon-linux-extras install nginx1 -y

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
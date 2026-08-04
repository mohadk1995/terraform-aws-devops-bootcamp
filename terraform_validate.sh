#!/bin/bash

set -e

echo "Formatting Terraform files..."
terraform fmt -recursive

echo "Initializing Terraform..."
terraform init

echo "Validating configuration..."
terraform validate

echo "Generating execution plan..."
terraform plan -out=tfplan

echo "Terraform plan completed successfully."
#!/bin/bash

set -e

echo "Destroying Terraform infrastructure..."
terraform destroy -auto-approve

echo "Terraform infrastructure destroyed successfully."
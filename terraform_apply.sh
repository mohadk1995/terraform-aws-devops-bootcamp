#!/bin/bash

set -e

echo "Applying changes to the Terraform files..."
terraform apply -auto-approve


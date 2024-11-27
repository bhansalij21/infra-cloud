#!/bin/bash

# Define output file
OUTPUT_FILE="validation_output.txt"

# Start writing to the file
echo "### Terraform Outputs ###" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Capture Terraform outputs
echo "VPC ID:" >> $OUTPUT_FILE
tofu output vpc_id >> $OUTPUT_FILE 2>&1
echo "" >> $OUTPUT_FILE

echo "Subnet ID:" >> $OUTPUT_FILE
tofu output subnet_id >> $OUTPUT_FILE 2>&1
echo "" >> $OUTPUT_FILE

echo "Associated EC2 Instance IDs:" >> $OUTPUT_FILE
tofu output associated_ec2_instance_ids >> $OUTPUT_FILE 2>&1
echo "" >> $OUTPUT_FILE

echo "Associated EC2 Public IPs:" >> $OUTPUT_FILE
tofu output associated_ec2_public_ips >> $OUTPUT_FILE 2>&1
echo "" >> $OUTPUT_FILE

# Capture AWS CLI validation
echo "### AWS CLI Validation ###" >> $OUTPUT_FILE
vpc_id=$(tofu output vpc_id | tr -d '"') # Extract VPC ID
if [[ -z "$vpc_id" ]]; then
  echo "Error: VPC ID is not available in Terraform outputs." >> $OUTPUT_FILE
else
  echo "EC2 Instances in VPC $vpc_id:" >> $OUTPUT_FILE
  aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpc_id" \
    --query "Reservations[*].Instances[*].[InstanceId,PublicIpAddress]" \
    --output table >> $OUTPUT_FILE 2>&1
fi

# Print completion message
echo "Validation output captured in $OUTPUT_FILE"
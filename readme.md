# Infra-Cloud: Modular Infrastructure Automation with OpenTofu
## **OpenTofu VPC and EC2 Infrastructure**
Infra-Cloud is a modular infrastructure automation project using OpenTofu (Terraform fork). It provisions a cloud-native VPC environment and dynamically deploys scalable EC2 instances. The repository is designed for flexibility, allowing easy addition of resources and enabling seamless validation of relationships between infrastructure components.

Key Features:
-	VPC Automation: Creates a fully configurable VPC with subnets, route tables, and an internet gateway.
-	Dynamic EC2 Scaling: Deploys EC2 instances dynamically using for_each, ensuring efficient resource management.
-	Validation Outputs: Provides detailed outputs for resource IDs and relationships, with built-in testing using Terraform outputs and AWS CLI.
-	Modular Structure: Clean separation of VPC and EC2 modules for easy scalability and reusability.

Perfect for cloud infrastructure enthusiasts looking to automate and manage their environments with simplicity and flexibility.

---
## **Project Overview**

### **Key Features**
- Modular structure for VPC and EC2 instance provisioning.
- Dynamic scaling of EC2 instances using `for_each`.
- Outputs for VPC and EC2 relationships, accessible for validation.

### **File Structure**
```plaintext
.
├── main.tf              # Root configuration
├── variables.tf         # Variables for dynamic configurations
├── outputs.tf           # Outputs for root module
├── vpc/                 # VPC module
│   ├── main.tf          # VPC resources (VPC, Subnet, IGW, etc.)
│   ├── outputs.tf       # Outputs for VPC module
│   ├── variables.tf     # VPC variables
├── ec2/                 # EC2 module
│   ├── main.tf          # EC2 resources (instances, security groups)
│   ├── outputs.tf       # Outputs for EC2 module
│   ├── variables.tf     # EC2 variables
```
---
## **Prerequisites**

1. **Install OpenTofu**
   ```bash
   brew install opentofu
   ```
   Verify installation:
   ```bash
   tofu --version
   ```

2. **Install AWS CLI**
   ```bash
   brew install awscli
   ```
   Configure AWS credentials:
   ```bash
   aws configure
   ```
   Verify AWS access:
   ```bash
   aws sts get-caller-identity
   ```
---
## **How to Run**

### **1. Clone the Repository**
```bash
git clone <repository-url>
cd <repository-directory>
```

### **2. Initialize OpenTofu**
```bash
tofu init
```

### **3. Plan the Infrastructure**
```bash
tofu plan -out myplan
```

### **4. Apply the Configuration**
```bash
tofu apply myplan
```

---

## **How to Test and Validate**

### **1. Verify Terraform Outputs**

- List the VPC ID:
  ```bash
  tofu output vpc_id
  ```

- List the Subnet ID:
  ```bash
  tofu output subnet_id
  ```

- List associated EC2 instance IDs:
  ```bash
  tofu output associated_ec2_instance_ids
  ```

- List associated EC2 public IPs:
  ```bash
  tofu output associated_ec2_public_ips
  ```

---

### **2. Validate Resources Using AWS CLI**

- List all EC2 instances in the VPC:
  ```bash
  aws ec2 describe-instances --filters "Name=vpc-id,Values=<vpc-id>" \
    --query "Reservations[*].Instances[*].[InstanceId,PublicIpAddress]" --output table
  ```

- Verify Subnet and Security Group Associations:
  ```bash
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[SubnetId,SecurityGroups]"
  ```

---

### **3. Test Connectivity to EC2 Instances**

1. Retrieve public IPs of the instances:
   ```bash
   tofu output associated_ec2_public_ips
   ```

2. SSH into an instance:
   ```bash
   ssh -i <path-to-key>.pem ec2-user@<public-ip>
   ```

3. Verify internet connectivity from the instance:
   ```bash
   curl https://google.com
   ```

---

## **How to Add More EC2 Instances**

1. Update the `ec2_instances` variable in `variables.tf` to include additional instances:
   ```hcl
   variable "ec2_instances" {
     default = {
       instance1 = {
         ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI
         instance_type = "t2.micro"
       }
       instance2 = {
         ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI
         instance_type = "t2.small"
       }
       instance3 = {
         ami           = "ami-0c55b159cbfafe1f0" # New instance
         instance_type = "t2.medium"
       }
     }
   }
   ```

2. Plan and apply the updated configuration:
   ```bash
   tofu plan -out myplan
   tofu apply myplan
   ```

---

## **How to Clean Up**

To destroy all resources created by this project:
```bash
tofu destroy
```

## **Verfication & Validation : Print output on cli**

### Validate Terraform Output Commands
```
tofu output vpc_id
tofu output subnet_id
tofu output associated_ec2_instance_ids
tofu output associated_ec2_public_ips
```

## **Verfication & Validation : Save output to a file**
```
chmod +x validate.sh
./validate.sh
cat validation_output.txt
```

### **Common Errors**

1. **Duplicate Resource Definition**:
   Ensure all resource and output names are unique within a module.

2. **Invalid AMI ID**:
   Use a valid AMI for your region. Query available AMIs:
   ```bash
   aws ec2 describe-images --owners amazon --query 'Images[*].[ImageId,Name]' --output text
   ```

3. **No Outputs Found**:
   Ensure outputs are correctly defined in `outputs.tf` and run:
   ```bash
   tofu refresh
   ```
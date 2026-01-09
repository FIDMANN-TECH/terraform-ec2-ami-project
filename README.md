# Terraform EC2 Instance and AMI Creation

## 📌 Project Overview
This project demonstrates how to use **Terraform** to automate the creation of an **EC2 instance on AWS** and generate a **custom Amazon Machine Image (AMI)** from that instance.

The project follows **Infrastructure as Code (IaC)** best practices and showcases Terraform fundamentals used in real-world DevOps workflows.

---

## 🎯 Objectives
- Write basic Terraform configuration files
- Automate EC2 instance creation on AWS
- Create a reusable AMI from an EC2 instance using Terraform
- Gain hands-on experience with Terraform lifecycle commands

---

## 🛠️ Prerequisites
Before starting this project, ensure you have the following:

- An active AWS Account
- AWS CLI installed and configured
- Terraform installed on your local machine
- IAM user with sufficient permissions for EC2 and AMI operations

---

## 📂 Project Structure

```bash
terraform-ec2-ami-project/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── README.md
└── img/
```

## 📄 Terraform Configuration Files

main.tf – Defines the EC2 instance and AMI resources

provider.tf – Configures the AWS provider and required versions

variables.tf – Declares reusable input variables

outputs.tf – Exposes key resource identifiers

## 🚀 Implementation Steps
### 1️⃣ Verify AWS CLI Configuration

Ensure that your AWS CLI is correctly configured and authenticated.

aws sts get-caller-identity


Capture the terminal output showing Account, UserId, and ARN.

### 2️⃣ Initialize Terraform

Initialize the Terraform working directory.

terraform init



### 3️⃣ Review Terraform Execution Plan

Preview the infrastructure changes Terraform will apply.

terraform plan



Capture the planned creation of the EC2 instance and AMI.

### 4️⃣ Apply Terraform Configuration

Provision the EC2 instance and create the AMI.

terraform apply
Type yes when prompted.


### 5️⃣ Verify Resources in AWS Console
✅ EC2 Instance

Navigate to AWS Console → EC2 → Instances

Confirm the instance status is Running



✅ Amazon Machine Image (AMI)

Navigate to EC2 → AMIs

Confirm the AMI status is Available


Capture AMI name and availability status.

### 6️⃣ Cleanup Resources 

Destroy all provisioned resources to avoid unnecessary AWS charges.

terraform destroy

## 🔍 Challenges & Observations (Implementation Insights)

During the implementation of this project, several practical observations and challenges were encountered and addressed:

#### AMI Creation Dependency Awareness:
While creating a custom AMI from an EC2 instance, it became clear that the AMI creation process must wait until the EC2 instance is fully provisioned and stable. This highlighted the importance of managing resource dependencies explicitly in Terraform to avoid race conditions.

#### User Data Execution Timing:
User Data scripts execute only during the first boot cycle of an EC2 instance. Any misconfiguration or failure requires instance recreation rather than a simple restart. This reinforced the need to validate User Data scripts carefully before applying changes.

#### Terraform State Sensitivity:
The Terraform state file contains sensitive infrastructure metadata. This observation informed the decision to exclude state files from version control and reinforced best practices around .gitignore and potential remote backends.

These challenges improved understanding of real-world Terraform behavior beyond simple resource creation.

## 🧩 Variables & Parameterization (Modularity Evidence)

To ensure modularity and reusability, the project uses parameterized variables defined in variables.tf. This approach avoids hardcoding values and allows the infrastructure to be easily adapted for different environments or regions.

Example Variable Definitions
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Base AMI ID for EC2 instance"
  type        = string
}

#### Why This Matters

Improves code reusability

Simplifies environment changes

Aligns with Terraform best practices

Enables scaling the configuration into modules if needed

### 🔗 Dependency Management Using depends_on

Terraform automatically infers many dependencies, but explicit dependency control was required in this project to ensure correct execution order—especially during AMI creation from an EC2 instance.

Explicit Dependency Example
resource "aws_ami_from_instance" "custom_ami" {
  name               = "terraform-custom-ami"
  source_instance_id = aws_instance.web_server.id

  depends_on = [
    aws_instance.web_server
  ]
}

### Dependency Handling Explanation

The depends_on argument ensures the EC2 instance is fully created and configured before AMI creation begins.

This prevents premature AMI creation, which could result in incomplete or unstable images.

Explicit dependencies improve predictability and reliability of Terraform runs.

### 🧠 Key Learning Reinforcement

Through this project, the following Terraform concepts were reinforced:

Explicit dependency management using depends_on

Infrastructure parameterization using variables

Safe handling of Terraform state

Lifecycle awareness of EC2 and AMI resources

Importance of documentation to reflect implementation intent

## 📤 Outputs

The following outputs are generated after successful execution:

EC2 Instance ID

Custom AMI ID

✅ Key Learnings

## Terraform resource lifecycle management

Infrastructure automation using Infrastructure as Code (IaC)

Dependency handling using depends_on

AWS EC2 instance provisioning

AMI creation and reuse

## 🏁 Conclusion

This project provides a solid foundation for using Terraform with AWS. It mirrors real-world DevOps workflows, reinforces Infrastructure as Code best practices, and is suitable for inclusion in a professional DevOps portfolio.

## Below are screenshots of workflow:
![aws-cli-configured](./img/01-aws-cli-configured.png)
![terraform-init-success](./img/02-terraform-init.png)
![terraform-validate-success](./img/03_terraform_validate_success.png)
![terraform-plan-success](./img/04-terraform-plan.png)
![terraform-apply-success](./img/05-terraform-apply.png)
![aws-console-ec2-running](./img/06-ec2-running.png)
![aws-console-ami-created](./img/07-ami-created.png)
![terraform-destroy-success](./img/08_terraform_destroy_success.png)


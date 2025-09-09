# A Concise guide for the terraform setup (For agent deployment on AWS)

**ID:** 962722
**Created At:** 2025-01-31T02:56:39+00:00
**Source:** https://codeberg.org/introspector/SOLFUNMEME/issues/91

---

Terraform Setup Guide
1. Install Required Tools
Install Terraform and AWS CLI v2:
Terraform Installation Guide
AWS CLI v2 Installation Guide
2. AWS Account Setup
Login as Root User:
Follow this guide to log in as the root user.
Enable Multi-Factor Authentication (MFA):
Use an MFA app such as Duo to enhance account security.
Create an IAM Admin User:
Create an admin user in AWS IAM.
Generate an access key for the user:
Follow this guide.
3. Configure AWS CLI
Run the following commands to configure AWS CLI with your access key:

sh
Copy
Edit
aws configure
aws sts get-caller-identity
4. Terraform Project Setup
Do not use the following Git commands:

sh
Copy
Edit
git clone https://github.com/jmikedupont2/ai-agent-terraform/
cd ai-agent-terraform/
git checkout feature/np-introspector
git checkout -b feature/<yourname>
cp -r accounts/np-introspector accounts/<yourname>
Edit Variables File
Open accounts/<yourname>/variables.tf using your preferred text editor (e.g., Emacs, Notepad).
Initialize and Deploy Terraform
Run the following commands inside your project directory:

sh
Copy
Edit
cd accounts/<yourname>/
terraform init
terraform plan
terraform apply
5. Reference Documentation
For additional details, refer to:

Project README
Key Terraform configuration files:
variables.tf
constants.tf
main.tf
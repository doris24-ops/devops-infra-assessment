# Terraform AWS Infrastructure

This repository contains Terraform modules and GitHub Actions workflows for provisioning and managing AWS infrastructure, including VPC, EKS, and ECR resources.

## Table of Contents

- [Overview](#overview)
- [Modules](#modules)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [State Management](#state-management)

## Overview

This project uses Terraform to define and provision AWS infrastructure components. It includes modules for VPC, EKS, and ECR, allowing for a modular and reusable approach to infrastructure management. GitHub Actions are used to automate the deployment and destruction of resources.

## Modules

The repository contains the following Terraform modules:

1. **VPC**: Defines the Virtual Private Cloud network structure.
2. **EKS**: Sets up an Elastic Kubernetes Service cluster.
3. **ECR**: Creates Elastic Container Registry repositories.

## GitHub Actions Workflows

Two GitHub Actions workflows are included in this repository:

1. **Infra Provision Apply**: Automatically applies Terraform changes when commits are pushed to the main branch.
2. **Infra Destroy**: A manually triggered workflow to destroy the infrastructure.

### Infra Provision Apply

This workflow runs on pushes to the main branch. It performs the following steps:
- Checks out the code
- Configures AWS credentials
- Sets up Terraform
- Initializes Terraform with the remote state bucket
- Validates the Terraform configuration
- Applies the Terraform changes with auto-approve

### Infra Destroy

This workflow can be manually triggered. It performs the following steps:
- Checks out the code
- Configures AWS credentials
- Sets up Terraform
- Initializes Terraform with the remote state bucket
- Validates the Terraform configuration
- Destroys the Terraform-managed infrastructure with auto-approve

## Prerequisites

To use this repository, you need:

1. An AWS account with appropriate permissions
2. AWS CLI installed and configured
3. Terraform installed (version specified in the workflow files)
4. GitHub repository secrets set up for AWS credentials:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

## Usage

1. Clone this repository
2. Modify the Terraform modules in the `modules/` directory as needed
3. Update the main Terraform configuration to use your modules
4. Commit and push changes to the main branch to trigger the provisioning workflow
5. To destroy resources, manually trigger the "Infra Destroy" workflow from the GitHub Actions tab

## State Management

Terraform state is managed remotely using an S3 bucket. The state file is stored at:

```
s3://tfstate-state-bucket-githubaction/main/terraform.tfstate
```

Ensure that you have the necessary permissions to access this bucket.

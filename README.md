## Overview

This repository contains the Terraform files and GitHub Actions workflow for managing the Infrastructure as Code (IaC) for your GitOps project. The IaC is used to provision and manage an Amazon Elastic Kubernetes Service (EKS) cluster and related resources on AWS. GitOps principles are applied to manage the infrastructure configuration and changes using Git version control.

## Prerequisites

Before using this repository, ensure you have the following:

- An AWS account with appropriate permissions to create and manage EKS clusters and related resources.
- AWS Access Key ID and Secret Access Key stored securely in GitHub Secrets.
- Basic knowledge of Terraform and GitOps concepts.
- Familiarity with AWS EKS and Kubernetes.

## Terraform Files

The terraform/ directory contains the following Terraform files:

- main.tf: Defines the EKS cluster and managed node groups.
- providers.tf: Specifies the AWS and Kubernetes providers.
- variables.tf: Defines input variables for the Terraform configuration.
- outputs.tf: Defines output values to be displayed after Terraform runs.
- modules/eks/: Contains the EKS module configuration for creating the cluster and node groups.
- terraform.tfvars: Contains the values for the input variables defined in variables.tf.

## GitHub Actions Workflow

The .github/workflows/gitops-iac.yml file defines a GitHub Actions workflow for automatically applying Terraform changes when code is pushed to the main or stage branch or when a pull request is made to main. The workflow uses AWS credentials stored in GitHub Secrets to authenticate with AWS and apply the Terraform changes.

### Workflow Steps

1. Checkout Source Code: Checks out the Terraform files.
2. Install Terraform: Sets up Terraform for use in the workflow.
3. Terraform Init: Initializes the Terraform configuration.
4. Check Terraform Format: Checks the formatting of Terraform files.
5. Validate Terraform Code: Validates the Terraform configuration.
6. Run Terraform Plan (Stage): Generates an execution plan for Terraform changes in the stage branch.
7. Pull Request to Main: A pull request is required to merge changes from stage to main.
8. Terraform Apply (Main): Applies Terraform changes if the pull request is merged into main.


## Usage

To use this repository, ensure you have set up your AWS credentials in GitHub Secrets and configured the required variables in the terraform.tfvars file. Push your changes to the stage branch to generate a Terraform plan and create a pull request to merge changes to the main branch to apply the Terraform changes and manage your EKS cluster using GitOps principles.

## Cleanup

To avoid incurring unnecessary charges, remember to clean up your resources when they are no longer needed. You can do this by following these steps:

1. **Remove Ingress Controller:**

- Remove the Kubernetes configuration file:

    ```sh
    rm -rf ~/.kube/config
    ```
- Update the kubeconfig file with the correct AWS EKS cluster name:

    ```sh
    aws eks update-kubeconfig --region "Region Name" --name "Cluster_Name"
    ```

2. **Destroy Terraform Infrastructure:**

- Configure the AWS CLI locally with the access key and secret key of the user.
- Run Terraform init with the backend configuration:
    ```sh
    terraform init -backend-config="bucket=bucket_name"
    ```
- Destroy the Terraform-managed infrastructure:
    ```sh
    terraform destroy
    ```

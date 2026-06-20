# Multi-Cloud IaC Templates for ML Infrastructure

Terraform modules that provision equivalent machine learning infrastructure
across Azure, AWS, and GCP — demonstrating consistent infrastructure-as-code
practices across cloud providers.

## Why this project

Enterprises rarely commit to a single cloud, and platform/AI teams are
often asked to support ML workflows wherever the organization's data and
compute already live. This repo shows how the same conceptual
architecture — artifact storage, an ML development/notebook environment,
and the IAM/security scaffolding around it — can be expressed consistently
as code across all three major providers.

## What each module provisions

| Component                  | Azure                              | AWS                              | GCP                                  |
|----------------------------|-------------------------------------|------------------------------------|----------------------------------------|
| Artifact storage            | Storage Account                     | S3 Bucket (versioned)              | GCS Bucket (versioned)                 |
| ML workspace / dev env       | Azure ML Workspace                  | SageMaker Notebook Instance        | Vertex AI Workbench                    |
| Secrets management           | Key Vault                           | IAM Role policies                  | Service Account + IAM bindings         |
| Observability                | Application Insights                | —                                  | —                                      |
| Identity                    | System-assigned managed identity    | IAM Role (SageMaker trust policy)  | Dedicated service account              |

## Project structure

```
project3-multicloud-iac/
├── azure/
│   ├── main.tf
│   └── variables.tf
├── aws/
│   ├── main.tf
│   └── variables.tf
├── gcp/
│   ├── main.tf
│   └── variables.tf
└── README.md
```

## Usage

Each cloud's module is independent and can be applied on its own. Example
for AWS:

```bash
cd aws
terraform init
terraform plan -var="artifacts_bucket_name=my-unique-bucket-name"
terraform apply -var="artifacts_bucket_name=my-unique-bucket-name"
```

Example for Azure:

```bash
cd azure
terraform init
terraform apply \
  -var="storage_account_name=mymlstorage001" \
  -var="key_vault_name=my-ml-kv-001" \
  -var="tenant_id=<your-tenant-id>"
```

Example for GCP:

```bash
cd gcp
terraform init
terraform apply \
  -var="project_id=<your-gcp-project-id>" \
  -var="artifacts_bucket_name=my-unique-ml-bucket"
```

## Design notes

- All resource names that must be globally unique (storage buckets, key
  vaults) are exposed as required variables rather than hardcoded.
- Each module follows least-privilege patterns for its respective IAM
  model (Azure managed identity, AWS IAM role trust policy, GCP service
  account + role bindings).
- Modules are intentionally kept independent rather than merged into a
  single multi-provider configuration, reflecting how most organizations
  actually manage multi-cloud — as separate, cloud-specific Terraform
  states.

## Roadmap

- [ ] Add a remote state backend example (Azure Storage / S3 / GCS) for each provider
- [ ] Add network isolation (VPC/VNet) variants for each module
- [ ] Add a comparison cost-estimation note per provider
- [ ] Add GitHub Actions workflow for `terraform plan` on PR

# GCP Terraform Project with Nginx, Cloud SQL, and GCS

This project sets up a Google Cloud Platform infrastructure using Terraform. It includes:

1. A Google Kubernetes Engine (GKE) cluster running Nginx pod with a service attached
2. A Cloud SQL instance (MySQL)
3. A Google Cloud Storage (GCS) bucket

## Prerequisites

- Terraform installed (version >= 0.14)
- Google Cloud SDK installed and configured
- A GCP project with necessary APIs enabled (Compute Engine, Kubernetes Engine, Cloud SQL, Cloud Storage)

## Usage

1. Clone this repository
2. Update the `terraform.tfvars` file with your project ID and desired region
3. Run `terraform init` to initialize the Terraform working directory
4. Run `terraform apply` and confirm to create the infrastructure 
5. Open IP from the output `nginx_service_ip = "<IP>" to see the webpage.

## Considerations

- There is no bucket configured for the tfstate file, which is a bad practice. I assumed this will be harder to test if there is an additional need to create a bucket.
- The webpage content is generated on the fly inside the code. This sometimes can be a good thing, but generally it's not a common practice. This is just for demo purposes.
- Lot of things could be variables but is not, as I treated this as a PoC. The same goes for the object names - most of them are my-name, which should be more informative in normal use.
- There is only one k8s node, which is not exactly HA, but it's cheaper than setting more of them, this can be changed easily.
- The security aspects are a bit overlooked (VPC is on the default configuration, SQL db is open to 0.0.0.0, the secret is inside tf variables in plain text etc.)

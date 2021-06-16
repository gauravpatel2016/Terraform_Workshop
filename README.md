# Terraform_Workshop

### What do you need?
- Terraform (brew install terraform)
- Docker 


## Problem Statements
1. Add a docker provider to main.tf. Is `version` optional?

    [Solution](TF_BASICS/01-The-Docker-Provider/main.tf)

2. Run `terraform init` and notice which files are created

    [Solution](TF_BASICS/02-Terraform-Init-Deeper-Dive/main.tf)

3. Refer docker provider page and Pull down `nodered/node-red:latest` docker image using TF. Hint: `terraform plan` followed by `terraform apply`
```
    Resource Name: `nodered_image`
    Name of image: `nodered/node-red:latest`
```

    [Solution](TF_BASICS/03-Your-First-Terraform-Apply/main.tf)

4. Refer docker provider page and Install `nodered/node-red:latest` image using TF. Hint: `terraform apply`

    [Solution](TF_BASICS/03-Your-First-Terraform-Apply/main.tf)

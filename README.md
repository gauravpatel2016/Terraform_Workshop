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

    Resource Name: nodered_image <br />
    Name of image: nodered/node-red:latest


    [Solution](TF_BASICS/03-Your-First-Terraform-Apply/main.tf)

4. Verify if image has been created.

   [Tooltip Solution](## "docker image ls | grep -i red")

5. Verify *.tfstate file. Run Plan again. What happened?

    [Tooltip Solution](## "No changes to Infrastructure")

6. Run `terraform destroy`. Verify *.tfstate file. 

   [Tooltip Solution](## "terraform destroy")

7. Export plan file. Hint: `terraform plan --help`. Are you able to read it?

   [Tooltip Solution](## "terraform plan -out=myTFPlan.plan")

8. Utilize the plan that you created in above step in `terraform apply`. Did you get a prompt?

   [Tooltip Solution](## "terraform plan myTFPlan.plan")

9. Create a destroy plan (don't export). Hint: `terraform plan --help`

   [Tooltip Solution](## "terraform plan -destroy")



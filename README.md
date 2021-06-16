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

4. Yay. Now Verify if image has been created.If answer is yes, You are a Rockstar.

   [Tooltip Solution](## "docker image ls | grep -i red")

5. Verify *.tfstate file. Run Plan again. What happened?

    [Tooltip Solution](## "No changes to Infrastructure")

6. Run `terraform destroy`. Verify *.tfstate file. 

   [Tooltip Solution](## "terraform destroy")

7. Congrats!!. You broke the infrastructure. Lets learn about back up plan file. Export plan file. Hint: `terraform plan --help`. Are you able to read it?

   [Tooltip Solution](## "terraform plan -out=myTFPlan.plan")

8. Utilize the plan that you created in above step in `terraform apply`. Did you get a prompt?

   [Tooltip Solution](## "terraform plan myTFPlan.plan")

9. Create a destroy plan (don't export). Hint: `terraform plan --help`

   [Tooltip Solution](## "terraform plan -destroy")

10. Take a deep breath. Compare `terraform plan --help` vs `terraform apply --help`. What do you notice?

    [Tooltip Solution](## "Most of the options are similar")

11. Let's get back to our infrastructure. Docker image is useless without container. Create a nodered container using terraform. Use `docker ps` once you apply. Looking for a hint? [Click Here for Hint](https://www.google.com)

    Resource Name: nodered_container <br />
    Name of container: nodered

    [Solution](TF_BASICS/05-Referencing-Other-Resources/main.tf)

12. If you managed to create a container without looking the solution, Get ready for this. Expose nodered container. [Hint:](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container#nestedblock--ports)

    internal: 1880 <br />
    external: 1880

    [Solution](TF_BASICS/06-Viewing-Your-Deployment/main.tf)

13. Hope by now, you're impressed by Terraform. How did terraform know to create image first then container. Let's Discuss tfstate file and dependencies. Perform Plan -> Verify tfstate file > destroy -> Verify tfstate/tfstate.backup file -> apply -> Verify tfstate file. 

14. As you can see, there could be better way to view terraform state file. Use `terraform show -json | jq` to view tfstate file. Using jq, you can utilize json path to view values.

15. Run `terraform state list`. Explain the output.

    [Tooltip Solution](## "This will show you all the resources managed by terraform and listed in tfstate.")

16. Run `terraform console`. Then run `docker_container.nodered_container.name`. What do you get? Now see if you can get IP of the container.

    [Tooltip Solution](## "docker_container.nodered_container.ip_address")

17. Let's get The IP address of the container and name of the container displayed on console after `terraform apply`. Hint: [Output Block](https://www.terraform.io/docs/language/values/outputs.html)

    [Solution](TF_BASICS/08-Terraform-Console-Outputs/main.tf)

18. For more advanced practice, go to `terraform console` and print external port to the console.

    [Tooltip Solution](## "docker_container.nodered_container.ports[0].external")

19. Now we need to output IP address with port. To achieve this, we need to use terraform functions. See if you can `join` ip address and port seperated by colon in output block. Hint: [Join Function](https://www.terraform.io/docs/language/functions/join.html)

    [Solution](TF_BASICS/09-Join-Function/main.tf)

20. Now comment out `external` port in main.tf. Why? Because we are going to spin up more containers and we do not want to hard code external port. If you remove external port, docker will choose it for you dynamically. Now create another resource for container. Apply and verify 2 containers. Later destroy everything.

    Resource Name: nodered_container2 <br />
    Name of container: nodered2

    [Solution](TF_BASICS/10-Random-Resource/main.tf)

21. Now create 4 containers!!! Nope, you don't have to copy/paste 4 times. Don't stress yourself. Let's do this step by step. Use `count=4` in container resource block. DO NOT RUN APPLY. Check this [document](https://www.terraform.io/docs/language/meta-arguments/count.html) first. Why we can't apply? Think about it.

    <details>
    <summary>Let me verify if my answer is correct</summary>
    <p>

    ```
    Docker doesn't allow same name containers. So if you set count to 4, it will be failed. 
    ```

    </p>
    </details>  
    
22. 

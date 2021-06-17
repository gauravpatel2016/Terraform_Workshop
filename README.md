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

20. Now comment out `external` port in main.tf. Why? Because we are going to spin up more containers and we do not want to hard code external port. If you remove external port, docker will choose it for you dynamically. Now create another resource for container. You have to add another output too. Apply and verify 2 containers. Later destroy everything.

    Resource Name: nodered_container2 <br />
    Name of container: nodered2

    [Solution](TF_BASICS/10-Random-Resource/main.tf)

21. Now if you're asked to create 4 containers!!! Nope, you don't have to copy/paste 4 times. Don't stress yourself. Let's do this step by step. There is an option to use `count=4` in container resource block. You don't need to add this line for now. Eventhough you add it,DO NOT RUN APPLY. Check this [document](https://www.terraform.io/docs/language/meta-arguments/count.html) first. Why we can't apply? Think about it. 

    <details>
    <summary>Let me verify if my answer is correct</summary>
    <p>
    ```
    Docker doesn't allow same name containers. So if you set count to 4, it will be failed. 
    ```
    </p>
    </details>  
    
22. Lets solve above problem first. Add another block for `Random String`. This block is not supported by Docker provider. You have to run a command which you already learned earlier after you add this block. Then run `terraform apply` Hint: [Random String](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) 

    [Solution](TF_BASICS/10.1-Random-Resource/main.tf)

23. Now run `terraform state list`. What do you notice?

24. Check the output of created random string. You do not need output block. You can verify this string somewhere in the code repository. You have learned it. Think about it.

    [Tooltip Solution](## "terraform show | grep -i result")

25. Alright !! So far so good. Now use a `join` function to add random string to name of the container 1. No Hint. You already know how to do this. 

    [Solution](TF_BASICS/10.2-Random-Resource/main.tf)

26. Create another random block and randomize container 2 name.

    [Solution](TF_BASICS/10.2-Random-Resource/main.tf)

27. Well this code is super messy. 2 random blocks. 2 container blocks. 4 output blocks.Not anywhere near DRY (Do not Repeat Yourself). Remember option `count=4` ??? Comment out everything in your file EXCEPT provider block and first random block. Add `count = 2` to random block. Run `terraform apply`. Verify random string using a command that you learned earlier.

    [Solution](TF_BASICS/10.3-Random-Resource/main.tf)

    [Tooltip Solution](## "terraform show")

28. What do you notice which is different than previous state files? Couldn't see the difference? Follow the steps and see if you notice the difference.

    terraform destroy <br />
    Comment out `count=2` and run `terraform apply`  <br />
    Run `terraform state list`  <br />
    terraform destroy <br />
    Uncomment out `count=2` and run `terraform apply`  <br />
    Run `terraform state list` 

29. How about now? Notice `random_string.random[0]` vs `random_string.random` ? If you add `count`, resources output requires indexes.  

30. Delete duplicated code such as, 2nd Random Block, 2nd Container block. Let's add `count=2` in Random block and Container 1 block.  Also uncomment image/container 1 block. Name should be random so you have to add index. Hint: `random_string.random[count.index].result`

    [Solution](TF_BASICS/11-Multiple-Resources-count/main.tf)

31. Run `terraform state list`. Notice indexes on Container and Random string.

32. Let's configure output blocks. We do not want to repeat output block. But we can't use `count.index` in output block. Let's start with container name output. Remove output for container 2 name block. Use splat expression `*`. Hint: [Splat](https://www.terraform.io/docs/language/expressions/splat.html)

    [Solution](TF_BASICS/12-Splat-Expression/main.tf)

33. Try replacing ip_address for container 1 to splat expression. What error do you get?

34. For ip address, you have to use `for` loop. Hint: [For Documentation](https://www.terraform.io/docs/language/expressions/for.html)
`[for i in docker_container.nodered_container[*] : i.name]`. Try with `terraform console` first before checking solution.

    [Solution](TF_BASICS/13-For-Loops/main.tf)

35. Create a variable `ext_port` for `external` port. Do same to `int_port` for `internal` Hint: [Variable Documentation](https://www.terraform.io/docs/language/values/variables.html)

    default = 1880
    type = int

    [Solution](TF_BASICS/17-Adding-Variables/main.tf)

36. Now comment `default` from `int_port`. Run `terraform plan` or `terraform apply`. What happened?

37. Do not uncomment `default`. Check `terraform plan --help` and find to pass variable value via command line argument

    [Tooltip Solution](## "terraform plan -var "int_port=1880"")





   





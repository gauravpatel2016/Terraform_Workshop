# Terraform_Workshop

### What do you need?
- Terraform (brew install terraform)
- Docker 

### Execute this command before problem statements

In `docker_volume` section, we run `sudo` and `terraform apply` will fail if sudo asks for password <br />
`touch text.txt; sudo chmod 755 text.txt; rm.text.txt`

### Things to consider while running Problem statements
- Always `terraform destroy` after `terraform apply`. 

## Problem Statements
1. Add a docker provider to main.tf. Is `version` optional?

    [Solution](TF_BASICS/_1-Provider_Intro/main.tf)

2. Run `terraform init` and notice which files are created

    [Solution](TF_BASICS/_2-Init/main.tf)

3. Refer docker provider page and Pull down `nodered/node-red:latest` docker image using TF. Hint: `terraform plan` followed by `terraform apply`

    Resource Name: nodered_image <br />
    Name of image: nodered/node-red:latest


    [Solution](TF_BASICS/_3-Apply/main.tf)

4. Yay. Now Verify if image has been created.If answer is yes, You are a Rockstar.

    <details>
    <summary>Solution</summary>
    <p>

    ```
        docker image ls | grep -i red
    ```

    </p>
    </details>

5. Verify *.tfstate file. Run Plan again. What happened?

    <details>
    <summary>Solution</summary>
    <p>

    ```
        No changes to Infrastructure
    ```

    </p>
    </details>

6. Run `terraform destroy`. Verify *.tfstate file. 

    <details>
    <summary>Solution</summary>
    <p>

    ```
        terraform destroy
    ```

    </p>
    </details>

7. Congrats!!. You broke the infrastructure. Let's learn about back up plan file. Export plan file. Hint: `terraform plan --help`. Are you able to read it?

    <details>
    <summary>Solution</summary>
    <p>

    ```
        terraform plan -out=myTFPlan.plan
    ```

    </p>
    </details>

8. Utilize the plan that you created in above step in `terraform apply`. Did you get a prompt?

     <details>
    <summary>Solution</summary>
    <p>

    ```
        terraform plan myTFPlan.plan
    ```

    </p>
    </details>

9. Create a destroy plan (don't export). Hint: `terraform plan --help`

    <details>
    <summary>Solution</summary>
    <p>

    ```
        terraform plan -destroy
    ```

    </p>
    </details>

10. Take a deep breath. Compare `terraform plan --help` vs `terraform apply --help`. What do you notice?

     <details>
    <summary>Solution</summary>
    <p>

    ```
        Most of the options are similar
    ```

    </p>
    </details>

11. Let's get back to our infrastructure. Docker image is useless without container. Create a nodered container using terraform. Use `docker ps` once you apply. Looking for a hint? [Click Here for Hint](https://www.google.com)

    Resource Name: nodered_container <br />
    Name of container: nodered

    [Solution](TF_BASICS/_4-Resources/main.tf)

12. If you managed to create a container without looking the solution, Get ready for this. Expose nodered container. [Hint:](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container#nestedblock--ports)

    internal: 1880 <br />
    external: 1880

    [Solution](TF_BASICS/_5-VerifyDeploy/main.tf)

13. Hope by now, you're impressed by Terraform. How did terraform know to create image first then container. Let's Discuss tfstate file and dependencies. Perform Plan -> Verify tfstate file > destroy -> Verify tfstate/tfstate.backup file -> apply -> Verify tfstate file. 

14. As you can see, there could be better way to view terraform state file. Use `terraform show -json | jq` to view tfstate file. Using jq, you can utilize json path to view values.

15. Run `terraform state list`. Explain the output.

    <details>
    <summary>Solution</summary>
    <p>

    ```
        This will show you all the resources managed by terraform and listed in tfstate.
    ```

    </p>
    </details>

16. Run `terraform console`. Then run `docker_container.nodered_container.name`. What do you get? Now see if you can get IP of the container.

    <details>
    <summary>Solution</summary>
    <p>

    ```
        docker_container.nodered_container.ip_address
    ```

    </p>
    </details>

17. Let's get The IP address of the container and name of the container displayed on console after `terraform apply`. Hint: [Output Block](https://www.terraform.io/docs/language/values/outputs.html)

    [Solution](TF_BASICS/_6-Output/main.tf)

18. For more advanced practice, go to `terraform console` and print external port to the console.

    <details>
    <summary>Solution</summary>
    <p>

    ```
        docker_container.nodered_container.ports[0].external
    ```

    </p>
    </details>


19. Now we need to output IP address with port. To achieve this, we need to use terraform functions. See if you can `join` ip address and port seperated by colon in output block. Hint: [Join Function](https://www.terraform.io/docs/language/functions/join.html)

    [Solution](TF_BASICS/_7-Join/main.tf)

20. Now comment out `external` port in main.tf. Why? Because we are going to spin up more containers and we do not want to hard code external port. If you remove external port, docker will choose it for you dynamically. Now create another resource for container. You have to add another output too. Apply and verify 2 containers. Later destroy everything.

    Resource Name: nodered_container2 <br />
    Name of container: nodered2

    [Solution](TF_BASICS/_8-Random/main.tf)

21. Now if you're asked to create 4 containers!!! Nope, you don't have to copy/paste 4 times. Don't stress yourself. Let's do this step by step. There is an option to use `count=4` in container resource block. You don't need to add this line for now. Eventhough you add it,DO NOT RUN APPLY. Check this [document](https://www.terraform.io/docs/language/meta-arguments/count.html) first. Why we can't apply? Think about it. 

    <details>
    <summary>Let me verify if my answer is correct</summary>
    <p>

    ```
    Docker doesn't allow same name containers. So if you set count to 4, it will be failed. 
    ```

    </p>
    </details>  
    
22. Let's solve above problem first. Add another block for `Random String`. This block is not supported by Docker provider. You have to run a command which you already learned earlier after you add this block. Then run `terraform apply` Hint: [Random String](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) 

    [Solution](TF_BASICS/_9-Random/main.tf)

23. Now run `terraform state list`. What do you notice?

24. Check the output of created random string. You do not need output block. You can verify this string somewhere in the code repository. You have learned it. Think about it.

    <details>
    <summary>Solution</summary>
    <p>

    ```
        terraform show | grep -i result
    ```

    </p>
    </details>

25. Alright !! So far so good. Now use a `join` function to add random string to name of the container 1. No Hint. You already know how to do this. 

    [Solution](TF_BASICS/_10-Random/main.tf)

26. Create another random block and randomize container 2 name.

    [Solution](TF_BASICS/_10-Random/main.tf)

27. Well this code is super messy. 2 random blocks. 2 container blocks. 4 output blocks.Not anywhere near DRY (Do not Repeat Yourself). Remember option `count=4` ??? Comment out everything in your file EXCEPT provider block and first random block. Add `count = 2` to random block. Run `terraform apply`. Verify random string using a command that you learned earlier.

    [Solution](TF_BASICS/_11-Random/main.tf)

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

    [Solution](TF_BASICS/_12-Count/main.tf)

31. Run `terraform state list`. Notice indexes on Container and Random string.

32. Let's configure output blocks. We do not want to repeat output block. But we can't use `count.index` in output block. Let's start with container name output. Remove output for container 2 name block. Use splat expression `*`. Hint: [Splat](https://www.terraform.io/docs/language/expressions/splat.html)

    [Solution](TF_BASICS/_13-Splat/main.tf)

33. Try replacing ip_address for container 1 to splat expression. What error do you get?

34. For ip address, you have to use `for` loop. Hint: [For Documentation](https://www.terraform.io/docs/language/expressions/for.html)
`[for i in docker_container.nodered_container[*] : i.name]`. Try with `terraform console` first before checking solution.

    [Solution](TF_BASICS/_14-For/main.tf)

35. Create a variable `ext_port` for `external` port. Do same to `int_port` for `internal` Hint: [Variable Documentation](https://www.terraform.io/docs/language/values/variables.html)

    default = 1880
    type = number

    [Solution](TF_BASICS/_15-Variables/main.tf)

36. Now comment `default` from `int_port`. Run `terraform plan` or `terraform apply`. What happened?

37. Do not uncomment `default`. Check `terraform plan --help` and find how to pass variable value via command line argument

    <details>
    <summary>Solution</summary>
    <p>

    ```
        terraform plan -var "int_port=1880"
    ```

    </p>
    </details>


38. Another option to set variable is using environment variable. Hint: [Env Variable Documentation](https://www.terraform.io/docs/language/values/variables.html#environment-variables)

    <details>
    <summary>Solution</summary>
    <p>

    ```
        export TF_VAR_int_port=1880; terraform plan
    ```

    </p>
    </details>

39. Unset `TF_VAR_int_port` and Uncomment `default`. Check

40. Ok now create another variable `container_count`

41. Let's breakdown this file. Create `variables.tf` and add all variables there. Create `outputs.tf` and move output there. Also change `container_count = 1`

    [Solution](TF_BASICS/_16-VarOutputs/)

42. Now create a file `terraform.tfvars` and add a variable `ext_port=1880`. Run `terraform plan`. [Read documentation](https://www.terraform.io/docs/language/values/variables.html#variable-definitions-tfvars-files)

    [Solution](TF_BASICS/_17-TFVAR/)


43. There are so many ways you can define/pass variables. Read [Variable Precedence](https://www.terraform.io/docs/language/values/variables.html#variable-definition-precedence)

44.  Run `terraform apply` first. Do not destroy. Now we are going to run commands inside docker container. For that, you can use `local_exec` [local_exec Documentation](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html) . You can pass local_exec provisioner to resource block directly but we are going to use [null_resource block](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)

    Run command `mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/` 

    null_resource name: `dockervol`

    [Solution](TF_BASICS/_18-DockerVol/main.tf)

45. Run `terraform apply` and see directory structure. Run `terraform destroy`. Did it remove volume?

46. Now Add volume to docker_container resource. Hint: [Documentation](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container#nestedblock--volumes)

    container_path = "/data" <br />
    host_path      = "/home/ubuntu/environment/terraform-docker/noderedvol"

    [Solution](TF_BASICS/_18-DockerVol/main.tf)

47. Run `terraform apply` and verify directory structure. 

48. View Exposed Container in the browser

    <details>
    <summary>Solution</summary>
    <p>

    ```
        http://localhost:1880
    ```

    </p>
    </details>


49. Create some chart in nodered. Later run `terraform destroy` then `terraform apply`. What do you notice?

50. Now Let's make our `ext_port` more predictable. If we increase no. of containers, we can't define `ext_port` unless we specify port number as a list. So first, go to `tfvars` file and make `ext_port` as a list `[1880,1881]`

51. Then, Change `ext_port` variable definition to `type=list(any)`. Think where is this defined?

52. Hmm. Now you changed `type=list`. Think what should you change in `container resource` block in main.tf?

    <details>
    <summary>Solution</summary>
    <p>

    ```
       change ext_port=var.ext_port[count.index]
    ```

    </p>
    </details>

53. Now you have to make sure you specify `count=2` in `container_count` variable. Run `terraform plan | grep external`. What do you get?

54. Change `count=3` in `container_count` variable. Run `terraform plan | grep external`. What do you get?

55. Let's make this more flexible. We do not want to hardcode this number. How about container_count's count = list size? Check [length function](https://www.terraform.io/docs/language/functions/length.html)

    <details>
    <summary>Solution</summary>
    <p>

    ```
        length(var.ext_port)
    ```

    </p>
    </details>


56. Run `terraform plan`. What happend?

57. To use function, you have to use `locals` [Documentation](https://www.terraform.io/docs/language/values/locals.html)

58. Now that you have added locals. You have to reference `container_count` in main.tf differently. It is not `var` anymore. Check documentation on how to use local. [Documentation](https://www.terraform.io/docs/language/values/locals.html)

59. There are lots of changes. Let's run `terraform plan` and `terraform apply` to see if everything works. If not, check the solution.

    [Solution](TF_BASICS/_19-Locals)

60. Now Let's do a small refactor. Notice our docker_volume host path is hardcoded. Use string interpolation. Replace path to `"${path.cwd}/noderedvol"`

61. We now want to introduce 2 lanes. dev and prod. We want to use different nodered images for dev and prod. Let's see how to do this step by step. 

62. Define `env` variable with `default` value = `dev`

63. Define `image` variable block.  Hint: [variable type map example](https://www.terraform.io/docs/configuration-0-11/variables.html#example)

    Use dev = `nodered/node-red:latest` <br />
        prod = `nodered/node-red:latest-minimal`

    
    <details>
    <summary>Let me verify if my answer is correct</summary>
    <p>

    ```
    variable "image" { 
        type        = map(any) 
        description = "Image for container" 
        default = { 
            dev  = "nodered/node-red:latest"
            prod = "nodered/node-red:latest-minimal"
        }
    } 
    ```

    </p>
    </details>  

64. Alright. We have defined variables with values. How our docker_image resource know what is the value of `env` and which `image` to use. Thanks to `lookup` function, this will be a piece of cake. Check documentation and complete the task. [Documentation](https://www.terraform.io/docs/language/functions/lookup.html)

    [Solution](TF_BASICS/_20-Maps)


65. Let's reduce ports list to `1880` and Run `terraform apply` and hope everything works.

66. Ok. Can you do same for ext_port now? I want to use, `[1980.1981]` if `env=dev` and `[1880,1881]` if `env=prod`. Give it a shot.

    <details>
    <summary>Hint</summary>
    <p>

    ```
        ext_port = {
            dev  = [1980, 1981]
            prod = [1880, 1881]
        }
    ```

    </p>
    </details>


67. Run `terraform plan`. What happened? Are you missing something? How about `lookup` in `main.tf` where you used `ext_port`

    [Solution](TF_BASICS/_21-Lookups)

68. Run `terraform  plan` and `terraform apply`.

69. Now create a directory named `image`. We are going to make this project modular. Create `main.tf`, `outputs.tf`, `providers.tf`, `variables.tf` inside this directory. We are going to move `docker_image` resource to this directory/main.tf

    [Solution](TF_BASICS/_22-Modules/image/)

70. Let's copy docker provider to image/providers.tf

    [Solution](TF_BASICS/_22-Modules/image/providers.tf)

71. Create a docker_image resource in main.tf

    name = `var.image_in`

    [Solution](TF_BASICS/_22-Modules/image/main.tf)

72. Now we have used `var.image_in`, let's define variable `image_in` in variables.tf

73. Now in our TF_ROOT directory, delete `docker_image` resource block. We are going to use module `image` that we have defined.

74. Add below code to main.tf:

    ```

    module "image" {<br />
        source   = "./image"<br />
        image_in = lookup(var.image, var.env)<br />
    }

    ```

75. Notice `module "image"` has option `image_in`. Our child module (`image` directory) is expecting variable `image_in`. This is how we pass the value to child module.

76. Now in root module main.tf, our `docker_container` resource block `image` option is broken. How are you going to fix that? Check module documentation and see how to use module output. [Documentation](https://www.terraform.io/docs/language/modules/syntax.html#accessing-module-output-values)

77. Create output of child module `image_out` with value `docker_image.nodered_image.latest`. You need to use this in root module `main.tf`

    <details>
    <summary>Solution</summary>
    <p>

    ```
       module.image.image_out
    ```

    </p>
    </details>


    [Solution](TF_BASICS/_22-Modules/)

78. Any idea how we are going to run this? 

    <details>
    <summary>Solution</summary>
    <p>

    ```
         First you have to `terraform init` in module `image` directory. Then in root module, `terraform plan` and `terraform apply` will work.
    ```

    </p>
    </details>

79. That's it folks. This should give you a good start. Below are some advanced concepts we use in our terraform projects.

### What's next?
[How to use AWS Modules](https://www.twitch.tv/videos/1057924189?t=04h00m00s)<br />
[for_each](https://www.terraform.io/docs/language/meta-arguments/for_each.html)<br />
[dynamic block](https://www.terraform.io/docs/language/expressions/dynamic-blocks.html)<br />
[template_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)<br />
[data block](https://www.terraform.io/docs/language/data-sources/index.html)<br />

[Terraform Associate Certification](https://learn.hashicorp.com/tutorials/terraform/associate-review)<br />
[Terraform Certification Preparation](https://www.youtube.com/watch?v=og76ViVI4ow)<br />




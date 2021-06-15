# Terraform_Workshop

### What do you need?
- Terraform (brew install terraform)
- Docker 

## Basics

#### Install Docker Plugin

<details>
  <summary>Click to expand!</summary>
  
```
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}
```
</details>


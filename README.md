<<<<<<< HEAD

# Terraform

=======

### Terraform

## IAC

- In Traditional way of managing Infra it will take araound 5 days each to build an environment like (stage or dev or prod).

- By using Terraform you can code your infra and can reuse the code and make some small changes and then build all env within 5 days.
- Moreover every thing is kept tracking by terraform.

## Terraform work flow

- Init ---> Validate ---> Plan ---> Apply ---> Destroy.

## terraform init

Purpose: Initialize the Terraform working directory.

What happens:

Downloads the required provider plugins (like AWS, Azure, etc.).

Initializes the backend (e.g., local, S3) to store the state file.

Prepares the environment for further commands.

✅ Use this command first whenever you:

Start a new Terraform project.

Add/change providers or modules.

## terraform validate

Purpose: Check if the Terraform configuration syntax is correct.

What happens:

Parses .tf files.

Verifies that the syntax and internal logic are valid.

Does not check actual cloud resources.

✅ Use this to catch typos or misconfigurations early.

## terraform plan

Purpose: Show what Terraform will do without making any changes.

What happens:

Compares current state (from the state file) with the configuration.

Lists additions, deletions, and updates.

Outputs a detailed execution plan.

✅ Use this before applying changes to review what will happen.

## terraform apply

Purpose: Apply the planned changes to your infrastructure.

What happens:

Executes the actions shown in terraform plan.

Provisions, updates, or deletes resources.

Updates the state file with the new state of your infrastructure.

✅ This is the actual deployment step.

## terraform destroy

Purpose: Delete all resources managed by Terraform.

What happens:

Reads the state file.

Destroys every resource created by Terraform.

Updates the state file to reflect that the infrastructure no longer exists.

✅ Use this to tear down your infrastructure (e.g., after testing or if no longer needed).

## Blocks, Block Labels, Arguments, Identifiers

## Top Level Blocks

    1. Terraform Settings Block
    2. Providers Block
    3. Resources Block
    4. Input variables block
    5. Output values block
    6. Local values Block
    7. Data source Block
    8. Modules Block

## Terraform Basic Blocks

1.  Terraform Settings Block

        - Special block used to configure some behaviour.
        - Specifing a required Terraform version.
        - Specify Provider Requirements
        - Configure Terraform Backend.

2.  Provider Block

    - Terraform relies on provider block to interact with Remote systems
    - Declare Providers for terraform to install providers and use them
    - Provider configuration belongs to root module

3.  Resource Block

    - Each Resource block declares one or more infrastrucute objects
    - Resources Behaviour
    - Configure the Resouce.

### Terraform Settings Block

- Called as Terraform Block or Terraform configuration Block.
- Each Terraform block can contains a number of settings related to Terraform's behaviour
- Within a terraform block, only constants values can be used, arguments may not refer to named objects such as resources, input variables, etc.. and may not use any of the Terraform language built-in functions.

- CONTAINS:
  1. required_version
  2. required_providers ---> (Defines the required providers, ite source and its version.)
  3. backend ---> (To configure the storage to store the logs and Terraform State information.)
  4. provider_meta (Optional and advanced).

### Terraform Providers

- Provider Requirements

- Provider Configuration

- Dependency Lock File

## Terraform Provider Registry

- The Terraform Provider Registry is an online repository (like a marketplace) hosted by HashiCorp where you can discover, download, and use providers to interact with different APIs, services, or platforms in your Terraform configuration.

- registry.terraform.io provides the "PROVIDERS" and "MODULES"

## Terraform Multiple Providers

- we can use Multiple providers to have multiple region support(as an example).
- we can use alternate provider in a resource, data or module by refering it as <PROVIDER NAME>.<ALIAS>

## Terraform Dependency Lock File

- It locks the provider versions to specific exact versions that Terraform has downloaded, even if your configuration uses version constraints like >= or ~>.

- After selecting a specific version of each dependency using VERSION CONSTRAINTS terraform remembers the decision it made in a dependency lock file so that it can(by default) make decisions again in future.

### Terraform Resources

- Syntatical Ex: resource "aws_istance" "ec2demo"{} ---> here "aws_istance" is Resource Type && "ec2Demo" is Local Name to use within the terraform.
- Meta Arguments: They are used to change the behaviour of the resource ex: provider inside resource block.
- Resource Arguments : ex: cidr_block = "10.1.0.0/16"

## Resource Behaviour

- Create Resource : Create Resource that exists in the configuration but that are not associated with real infrastructure object state.
- Destroy Resources : Destroy that exist in state but no longer in the configuration.
- Update in Place : Update in Place whose arguments have chnaged.
- Destroy and Recreate : Destroy and create arguments that are changed and that can't get updated.

## Resource Meta Arguments

# depends_on

- Simply let say resource 'B' can only be created when only resource 'A' is created, but the resource 'B' won't access the data of resource 'A'.

# Count

- When we want to create a 5 instances or n number of instances we use count.
- We can access the instances as , let say the resource local name is "web" so we can access each instance as aws_instance.web[0], aws_instance.web[0] ....

# for_each

- | Feature     | Description                                 |
  | ----------- | ------------------------------------------- |
  | Purpose     | Create multiple resources from a map or set |
  | Use case    | Multiple users, buckets, roles, etc.        |
  | Accessors   | `each.key` and `each.value`                 |
  | Input types | Set of strings or Map                       |
  | Flexibility | Greater control and naming vs. `count`      |

## Life Cycle

# Create_before_destroy

- Basically when ever a configuration changes and that change requires the destroy and create process at that time if we want to make sure about creating the new resource first and destroying the old one later.
- At such times we use " life_cycle {
  create_before_destroy = true
  }".

# prevent_destroy

- Similarly when we dont want to destroy any thing by any chance then we use this.
- " life_cycle {
  prevent_destroy = true
  }".

# ignore_changes

- When ever we changed some thing directly in the aws console. and after that when we normally run our terraform code it will revoke the changes.
- so to avoid that we use ignore_changes.
- life_cycle {
  ignore_changes = [tags, ....]
  }

### Terraform Variables

## Tearraform input Variables

# terraform input variables basics

- Create a variable block as
- variable "name"{
  type = string (or) number ...
  default = "some_default_value
  }

# terraform cli prompt fot i/p

- simply don't provide the default vaule. So it will ask for the value.

# Override the input from cli

- simply while performing plan enter -var = "ec2_instance_type = t2.small"

- To crate plan file we use terraform plan -out filename.out

# Envinormental variables

- can set in cli
- use Export TF_VAR_Variable_Name=<value>

# tfvar file to input

- Store the input variables in this file
- use "ec2_instance_type = "t3.xlarge""
- if the file name is not terraform.tfvar then use terraform plan -var-file=<file-name>.tfvars

# We can use Maps and list as type like string, number ....

# Protect sensitive input variables.

- Use sensitive = true so the info will be sensitive.

# Variable Definition Precedence

- environment variables
- terraform.tfvars
- terraform.tfvars.json
- _.auto.tfvars and _.auto.tfvars.json
- -var and -var-file

## Output Values

- To get the output on the console we create a output block. Ref: Terraform-variables/Output folder
- we can use terraform output to see the output that query the result stores in terraform.tfstate
- we can use sensitive=true to make it sensitive info.

# Passing the output to input for other module.

```t
📁 Path: modules/vpc/main.tf
resource "aws_vpc" "main" {
cidr_block = "10.0.0.0/16"
}

➕ Output the VPC ID

📁 modules/vpc/outputs.tf
output "vpc_id" {
description = "The ID of the created VPC"
value = aws_vpc.main.id
}

📁 Path: modules/subnet/variables.tf

variable "vpc_id" {
description = "VPC ID to launch subnet into"
type = string
}
📁 modules/subnet/main.tf

resource "aws_subnet" "main" {
vpc_id = var.vpc_id
cidr_block = "10.0.1.0/24"
}

📁 Root module main.tf
module "vpc" {
source = "./modules/vpc"
}

module "subnet" {
source = "./modules/subnet"
vpc_id = module.vpc.vpc_id # << Passing output from VPC module
}
```

## Local Values

- Local values assigns a name to an expression. so that you can use that name multiple times within a module without repeating the exp.

### DATA SOURCES

- Data sources allow Terraform to fetch information about existing resources — either within your current AWS account or from external systems — and use that data to configure other resources.

- 🤔 Why Use Data Sources?

| Scenario                                | Why Use Data Source?                   |
| --------------------------------------- | -------------------------------------- |
| Referencing existing AWS resources      | To avoid duplication                   |
| Getting dynamic values (like AMI IDs)   | To make code reusable                  |
| Working in shared infrastructure setups | To use pre-created VPCs, subnets, etc. |

- We use filters to get the accurate data

### Terraform State and State Locking

Great question! Understanding **Terraform State Backends** and **State Locking** is **critical for working in teams and managing infrastructure safely**.

Let’s break it down clearly and simply.

---

## 🗂️ What Is Terraform State?

- Terraform maintains a **state file** (`terraform.tfstate`) to **track the real infrastructure** and **what Terraform created**.

---

## 📦 What Is a Terraform State Backend?

A **backend** in Terraform defines **where** the Terraform state file is stored.

### ✅ Common Backends:

```t
| Backend          | Description                                       |
| ---------------- | ------------------------------------------------- |
| `local`          | Default — stores `terraform.tfstate` locally      |
| `s3`             | Stores state remotely in AWS S3 (great for teams) |
| `remote`         | Stores state in Terraform Cloud                   |
| `azurerm`, `gcs` | Backends for Azure/GCP                            |
```

---

## 🧠 Why Use a Remote Backend?

If you're working **alone**, local state is fine.
But if you're working in a **team**, local state causes issues like:

- Conflicts from multiple users applying at once
- No centralized state
- No audit/logging

That’s why you use **remote backends** like **S3 with DynamoDB locking**.

---

## 🔐 What Is State Locking?

State locking **prevents concurrent operations** from corrupting the state file.

### 🧱 How Locking Works:

- When a user runs `terraform apply`, the state is **locked**.
- While it's locked, others **cannot apply or modify** state.
- Once the operation completes, the lock is **released**.

---

## 🛠 Example: Using S3 Backend with Locking

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"  # for state locking
  }
}
```

### 💡 `dynamodb_table` enables state locking.

You must create the table manually:

```bash
aws dynamodb create-table \
  --table-name terraform-lock-table \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

---

## 🛡️ Why State Locking Matters

| Without Locking                   | With Locking                         |
| --------------------------------- | ------------------------------------ |
| Risk of state corruption          | Safe, exclusive access               |
| Two people can apply at same time | One person gets lock, others wait    |
| No history of who changed what    | Easier to control in CI/CD pipelines |

---

## ✅ Summary

| Concept               | Explanation                                                 |
| --------------------- | ----------------------------------------------------------- |
| **State Backend**     | Where Terraform stores `.tfstate` (local, S3, remote)       |
| **Remote Backend**    | S3, Terraform Cloud, etc. — centralizes state               |
| **State Locking**     | Prevents concurrent `apply` or `plan` from corrupting state |
| **Locking Mechanism** | Typically done with DynamoDB when using S3 backend          |

---

- In terraform backend we have to consider only where the state is stored and where the operations are performed.

- State Storage : Terraform uses persistant state data to keep track on resources it manages.
- State Lock : It is to avoid the conflicts while a group of people managing same storage.
- Operations : The CRUD API's that performed on Infra.

## Terraform State Commands

- Terraform show - Gives the state file as output
- Terraform refresh - when ever there are some manual changes happened to our infra so that changes will get updated in our state file.
- terraform state list - will list all the resources in the terraform state
- terraform state show - will show all the attributes of the terraform resource
- terraform state mv <oldName> <newName> to rename
- Terraform rm - To remove unwanted resources. By using this we can remove resource from state so terraform wont manage the resource. we can handle it by our own.
- Terraform replace-provider - we can chnage the provider using this.
- Terraform state pull and terraform state push - we can push and pull the state files into and from backend
- terraform force-unlock <LockID>
- terraform taint and untaint
- Terraform will mark that resource as "tainted", meaning it is considered damaged or needs to be recreated — even if nothing in the code has changed.
- to untaint terraform untaint aws_instance.web
- 🎯 What is Terraform Targeting?
  Terraform Targeting allows you to apply changes to specific resources only instead of applying changes to your entire infrastructure.

This is done using the -target flag with the terraform apply or terraform plan command.

### Terraform workspace

- A common usecase of multiple workspace is create a parllel, distinct copy of infra, in order to test the changes that will be happen with out changing the main flow of infra.

- Ex. a developer working on a complex infra might create a temporary work space inorder to freely experiment the chnanges without affectig the main work flow.

- Some Cmds : terraform workspace show, terraform workspace list, terraform workspace new, terraform workspace select, terraform workspace delete

```

```

### Terraform Provisioners

- Provisioners in Terraform are used to execute scripts or commands on a local machine or remote resource after it's created or before it's destroyed.

- They are typically used for bootstrapping, initial setup, or cleanup tasks.

- Provisioners are used to:

Install software on a newly created EC2 instance.

Run configuration scripts.

Push files (e.g., configs) to remote machines.

Run commands before destroying resources (cleanup).

```t
- Example:
  resource "aws_instance" "web" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
  inline = [
  "sudo apt update",
  "sudo apt install -y nginx"
  ]
  }

  connection {
  type = "ssh"
  user = "ubuntu"
  private_key = file("~/.ssh/id_rsa")
  host = self.public_ip
  }
  }
```

## File Provisioner

- It is used to copy files or directeries from terraform executing machine to newly created resources.

## Local Exec Provisoner

- Executes a command on the machine where Terraform is being run (i.e., your local laptop or CI/CD runner).

## Remote Exec Provisioner

- Executes commands on the remote resource after it's provisioned (e.g., an EC2 instance).

- Uses SSH or WinRM to connect.

### Null Resource & Provisioner

- A null_resource is a special Terraform resource that does nothing on its own, but can be used with provisioners to run scripts or commands.
  🔸 Why use it?
  To run local or remote scripts independently of cloud resources.

- To trigger actions based on changes to input variables or files.

- To act as a placeholder for automation steps.

# Note:

- Even there is some change in provisioner the done and you ran terraform apply, it wont get changed because terraform wont track provisioners.

- If there is some failure or fault in provisioners the whole apply will get failed
- If we want to use terraform apply even there is fault in provisioners the we use --> `on_failure = true`

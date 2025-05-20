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

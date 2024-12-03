# Shell Script for AWS IAM Management

This poject is to create more functions in to the already existing shell script ***"aws_cloud_manager.sh"***, to include IAM mangement. That is is the first and overall task

### Task 2: Define IAM User Names Array

```
#! /bin/bash

# Array of users names
users=("Emeka" "Chika" "TJ" "Wisdom" "Samuel")
```

I defined a variable that is an array. An array named ***users*** is declared, containing the names of different users. Each user's name will be name of an IAM user.

### Task 3: Create IAM Users by iterating through the IAM user names array using AWS CLI commands.

```
for user in "${users[@]}; 
do
echo "Creating IAM user: $user"
# check if user exists
aws iam get-user --user-name "$user" >/dev/null 2>&1
if [ $? -eq 0 ]; then
# create IAM users using AWS CLI 
        aws iam create-user --user-name "$user"
        if [ $? -eq 0 ]; then
                echo "Successfully created user: $user"
        else
                echo "Failed to create user: $user"
        fi
done

echo "User creation process complete."
```

This line initiates a loop that iterates over each element in the users array. For each iteration, the value of the current user name is stored in the variable user

The syntax ${user[@]} in Bash refers to all elements in the array "users".

[@]: This is an index or slice syntax specific to arrays in Bash. It signifies that we want to access all elements of the array.

**"$user" >/dev/null 2>&1**: This part redirects both standard output (stdout) and standard error (stderr) to /dev/null, a special device file that discards all output. This effectively suppresses any output from the command -v command.

```
# create IAM users using AWS CLI 
        aws iam create-user --user-name "$user"
```
This command creates the IAM user using the AWS CLI

`if [ $? -eq 0 ]; then`

This line checks the exit status of the previous command (aws iam create-user).

```
echo "Successfully created user: $user"
        else
                echo "Failed to create user: $user"
        fi
done
```

Based on the exit status of the aws iam create command, we print a corresponding message indicating whether the bucket creation was successful or not.

### Task 4: Create IAM Group named "admin" with a function using AWS CLI

```
create_group() {
        group_name="admin"

        echo "Creating IAM group: $group_name"
        aws iam create-group --group-name "$group_name"
        if [ $? -eq 0 ]; then
                echo "Successfully created IAM group: $group_name"
        else
                echo "Failed to create IAM group"
        fi
}

# Call the function to create IAM group
create_group
```

```
create_group() {
        group_name="admin"
```

This line begins the definition of a shell fuction named ***create_group***

`aws iam create-group --group-name "$group_name"`

This command creates the IAM group using the AWS CLI and names it with the name stored in the "group_name" string.

`if [ $? -eq 0 ]; then`

This line checks the exit status of the previous command (aws iam create-group).

```
# Call the function to create IAM group
create_group
```
This line calls the **"create_group"** function

### Task 5: Attach Administrative Policy to Group

```
POLICY_ARN="arn:aws:iam::awspolicy/AdministratorAccess"

echo "Attaching policy 'POLICY_ARN' to the group '$group_name'..."
ATTACH_POLICY=$(aws iam attach-group-policy --group-name "$group_name" --policy-arn "POLICY_ARN" 2>&1)

        if [[ $? -ne 0 ]]; then
                echo "Error: Failed to attach policy."
                exit 1
        fi

 echo "Policy '$POLICY_ARN' successfully attached to the group '$group_name'."
```

`POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"`

This line indicates the Amazon Resource Name (ARN) of the AWS-managed policy (AdministratorAccess in this case).

`ATTACH_POLICY=$(aws iam attach-group-policy --group-name "$group_name" --policy-arn "POLICY_ARN" 2>&1)`

**aws iam attach-group-policy** attaches the specified policy to the group

**2>&1** captures output/errors, checks the command's exit status to ensure success.

Then we confirm success with the echo commmand.

### Task 6: Assign users to group by iterating through the array of user names. 

```
# Iterate through the array of usernames
for user in "${users[@]}"; do
        echo "Adding user '$user' to group '$group_name'..."

        # Add the user to the group
        ADD_USER_OUTPUT=$(aws iam add-user-to-group --group-name "$group_name" --user-name "$user" 2>&1)

        if [[ $? -ne 0 ]]; then
                echo "Error: Failed to add user '$user' to group '$group_name'.
        else
                echo "User '$user' successfully added to group '$group_name'
        fi
done
```

Let's break this down

```
for user in "${users[@]}"; do
        echo "Adding user '$user' to group '$group_name'..."
```
This line loops through the array "users" and performs actions for each user.

`ADD_USER_OUTPUT=$(aws iam add-user-to-group --group-name "$group_name" --user-name "$user" 2>&1)`

This command adds each user to the specified group using the aws iam add-user-to-group command.

So our full shell script will now look like this

```
#!/bin/bash

# Environment variables
ENVIRONMENT=$1

users=("Emeka" "Chika" "TJ" "Wisdom" "Samuel")


check_num_of_args() \{
# Checking the number of arguments
if [ "$#" -ne 0 ]; then
    echo "Usage: $0 <environment>"
    exit 1
fi
\}

activate_infra_environment() \{
# Acting based on the argument value
if [ "$ENVIRONMENT" == "local" ]; then
  echo "Running script for Local Environment..."
elif [ "$ENVIRONMENT" == "testing" ]; then
  echo "Running script for Testing Environment..."
elif [ "$ENVIRONMENT" == "production" ]; then
  echo "Running script for Production Environment..."
else
  echo "Invalid environment specified. Please use 'local', 'testing', or 'production'."
  exit 2
fi
\}

# Function to check if AWS CLI is installed
check_aws_cli() \{
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it before proceeding."
        return 1
    fi
\}

# Function to check if AWS profile is set
check_aws_profile() \{
    if [ -z "$AWS_PROFILE" ]; then
        echo "AWS profile environment variable is not set."
        return 1
    fi
\}

for user in "${users[@]};
do
# check if user exists
aws iam get-user --user-name "$user" >/dev/null 2>&1
if [ $? -eq 0 ]; then
echo "User $user already exist. Skipping creation"
else
        echo "Creating IAM user: $user"
        aws iam create-user --user-name "$user"
        if [ $? -eq 0 ]; then
                echo "Successfully created user: $user"
        else
                echo "Failed to create user: $user"
        fi
fi
done

echo "User creation process complete."

# Creating IAM group
create_group() {
        group_name="admin"

        echo "Creating IAM group: $group_name"
        aws iam create-group --group-name "$group_name"
        if [ $? -eq 0 ]; then
                echo "Successfully created IAM group: $group_name"
        else
                echo "Failed to create IAM group"
        fi
}

# Attaching policy to the group
POLICY_ARN="arn:aws:iam::awspolicy/AdministratorAccess"

echo "Attaching policy 'POLICY_ARN' to the group '$group_name'..."
ATTACH_POLICY=$(aws iam attach-group-policy --group-name "$group_name" --policy-arn "POLICY_ARN" 2>&1)

        if [[ $? -ne 0 ]]; then
                echo "Error: Failed to attach policy."
                exit 1
        fi

echo "Policy '$POLICY_ARN' successfully attached to the group '$group_name'."

# Iterate through the array of usernames
for user in "${users[@]}"; do
        echo "Adding user '$user' to group '$group_name'..."

        # Add the user to the group
        ADD_USER_OUTPUT=$(aws iam add-user-to-group --group-name "$group_name" --user-name "$user" 2>&1)

        if [[ $? -ne 0 ]]; then
                echo "Error: Failed to add user '$user' to group '$group_name'.
        else
                echo "User '$user' successfully added to group '$group_name'
        fi
done




check_num_of_args
activate_infra_environment
check_aws_cli
check_aws_profile
create_group
```

#Thanks

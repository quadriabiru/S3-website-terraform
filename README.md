# AWS-S3-TERRAFORM

This repository contains a Terraform configuration for setting up an Amazon S3 bucket optimized for web hosting. The configuration includes the creation of an S3 bucket, policy settings for permissions, and the ability to upload website files. Output is supposed to be the url for your static s3 website

## Overview

The Terraform code provisions an S3 bucket for hosting static websites. It includes policies to manage access and control over the bucket, as well as configurations for web hosting settings.

### Key Features

- **S3 Bucket Creation**: Creates an S3 bucket for storing your web files.
- **Bucket Policy**: Configures a policy to allow public access for certain actions (like uploading objects).
- **Object Management**: Automatically uploads HTML, CSS, JavaScript, and image files from a specified directory.
- **Website Configuration**: Sets the index document for web hosting.
- **Ownership and Access Controls**: Configures bucket ownership controls and public access settings.

## Configuration Files

### main.tf

This is the main configuration file where the S3 bucket and its properties are defined.

#### Key Resources

- **S3 Bucket**: Create the S3 bucket using the `bucket` variable.
- **Bucket Policy**: Controls access permissions. The `Sid` can be modified to customize the policy.
- **S3 Objects**: Uploads files from a local directory. The path to the directory can be set in `directory_name`.
- **Ownership Controls**: Ensures that the bucket owner has preferred ownership over objects.
- **Public Access Block**: Controls whether public access to the bucket is blocked.
- **Bucket ACL**: Sets the bucket's access control list, currently set to private.
- **Website Configuration**: Specifies the index document (default is `index.html`).

### provider.tf

Defines the AWS provider and specifies the required version. Be sure to update the region and provide credentials (ideally using a `.tfvars` file for security).

### variables.tf

Defines variables that can be customized:

- **aws_region**: Specifies the AWS region for the bucket.
- **access_key**: Your AWS account access key (use a `.tfvars` file for security).
- **secret_key**: Your AWS account secret key (use a `.tfvars` file for security).
- **bucket_name**: The name of the S3 bucket (must be globally unique).
- **directory_name**: The directory where your web files are located.

### locals.tf

Defines local variables, particularly for content types, to ensure the correct metadata is applied to uploaded files.

## Modifying Variables

To customize your setup, you can modify the following variables:

- **`aws_region`**: Change this to the desired AWS region for deployment (e.g., `us-west-2`).
- **`access_key`** and **`secret_key`**: Set your AWS credentials. It's recommended to use environment variables or a separate `.tfvars` file instead of hardcoding.
- **`bucket_name`**: Set your desired unique bucket name. Remember that S3 bucket names must be globally unique across all AWS accounts.
- **`directory_name`**: Specify the path to your web files. Ensure it contains all the necessary files (HTML, CSS, images) you want to upload.

### Impact of Modifications

- Changing the **`bucket_name`** will create a new bucket; ensure the name is unique.
- Modifying the **bucket policy** affects who can access the contents of your bucket. Be cautious with public access settings.
- Altering **object upload settings** (like the directory name) can change which files are hosted, impacting the website’s content.
- Adjusting the **index document** affects the default landing page of your website.

## Usage

1. Update the variables in a `terraform.tfvars` file or set them as environment variables.
2. Initialize Terraform: 
   ```bash
   terraform init
   ```
3. Apply the configuration:
   ```bash
   terraform apply
   ```

This will create the resources as defined in the configuration files.

## Contributing

Feel free to submit issues or pull requests for improvements or enhancements to this Terraform configuration.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

### References that helped me:
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- https://pfertyk.me/2023/01/creating-a-static-website-with-terraform-and-aws/
- https://dev.to/ankursheel/how-to-upload-multiple-files-to-aws-s3-using-terraform-24bl

# TextBar Website Hosting with API Gateway and DynamoDB

This project sets up a static website on S3 with API Gateway for data submission and DynamoDB for storing entries.

## Components

- **S3**: Hosts the static website (index.html, error.html).
- **API Gateway**: Manages the API for submitting and retrieving text entries.
- **Lambda Functions**: Handles backend logic for interacting with DynamoDB.
- **DynamoDB**: Stores submitted entries. (In this case we are using exist dynamodb via api, If you want to use the new dynamodb you will need to change the index.html file.)

## Setup

### Prerequisites

- AWS Account
- Terraform
- AWS CLI

### Steps to Deploy

1. **Clone the Repository & Connect to your aws account**:

   ```bash
   git clone https://github.com/rtzi-hub/textbar-website.git
   aws configure
   ```
2. **Initialize and Apply Terraform**

   ```bash
   terraform init
   terraform apply
   ```
3. **Access the Website**
   Once the deployment is complete, access the S3 website URL to submit and view entries.
   you can use this command to reveal the s3 url:
   ```bash
   terraform output
   ```


## Cleanup
```bash
terraform destroy
```

Example of the website

Url for exist website: http://textbarwebsite.s3-website-us-east-1.amazonaws.com
![Screenshot 2024-12-09 135822](https://github.com/user-attachments/assets/17af671c-0c73-4f5c-a44d-4fff8e4cc973)

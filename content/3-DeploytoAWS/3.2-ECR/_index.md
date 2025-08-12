---
title : "Prepare Container Images"
date: "2025-08-12"
weight : 2
chapter : false
pre : " <b> 3.2 </b> "
---

#### Amazon ECR Overview

**Amazon Elastic Container Registry (Amazon ECR)** is a **fully managed Docker container registry** that makes it easy for developers to **store, manage, and deploy Docker container images**. ECR is integrated with Amazon Elastic Container Service (ECS), simplifying your development to production workflow.

Amazon ECR provides several key benefits:

- **Secure Image Storage**: ECR automatically **encrypts images at rest** and provides **vulnerability scanning** to identify security issues in your container images before deployment.
- **High Performance**: ECR is designed for **high availability and scalability**, with images stored across multiple Availability Zones for redundancy and fast image pulls.
- **Seamless Integration**: **Native integration with ECS and EKS** enables automated image deployment, while **IAM integration** provides fine-grained access control to your repositories.
- **Cost Effective**: You only **pay for the storage you use** and data transfer, with no upfront fees or minimum commitments.

Throughout this section, we'll establish our container image pipeline by creating an ECR repository and building **two application images**: the **main application container** and the **administrative dashboard container**. These images will serve as the foundation for our ECS deployment.
___

#### Create Repository

1\. Navigate to Amazon ECR:
   - In the AWS Console search bar, type `ECR`
   - Select **Elastic Container Registry** from the dropdown

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-06-29.png)

2\. Click **Create repository**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-11-55.png)

3\. Configure the General settings:
   - **Repository name**: Enter `questionbank-app`
   - Leave other settings as default

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-10-41.png)

4\. Scroll to the bottom and click **Create repository**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-14-49.png)

5\. **Verify creation**: Confirm that the **fcj-registry** repository appears in your ECR console. Note the repository URI as you'll need it for pushing images.


{{% notice info %}}
Before proceeding with this section, you need to configure AWS CLI with proper credentials to push images to ECR. Follow these steps to set up a workspace-specific AWS profile that won't affect your global machine configuration.

**Step 1: Create Workspace AWS Configuration**
1. Create a dedicated AWS configuration folder in your project:
   ```
   mkdir .aws-workspace
   ```
2. Create two empty files inside this folder:
   - `.aws-workspace/credentials`
   - `.aws-workspace/config`
3. Add to your `.gitignore` file:
   ```
   /.aws-workspace/*
   ```

**Step 2: Create IAM User Access Keys**
1. Go to **AWS Console** → **IAM** → **Users** → Select your user
2. Navigate to **Security credentials** tab → Click **Create access key**
3. **Step 1**: Choose **Command Line Interface (CLI)** → Click **Next**
4. **Step 2**: Add description tag (optional): `ECR-Local-Access` → Click **Create access key**
5. **Step 3**: **Copy both values immediately**:
   - Access key ID
   - Secret access key
   ⚠️ **Important**: Save these securely and never commit them to version control.

**Step 3: Configure Credential Files**
Create `.aws-workspace/credentials` with content:
```
[questionbank]
aws_access_key_id=AKIA...your-access-key...
aws_secret_access_key=...your-secret-key...
```

Create `.aws-workspace/config` with content:
```
[profile questionbank]
region=ap-southeast-1
output=json
```

**Step 4: Activate Profile in Terminal**
**PowerShell (Windows):**
```powershell
$env:AWS_CONFIG_FILE = ".\\.aws-workspace\\config"
$env:AWS_SHARED_CREDENTIALS_FILE = ".\\.aws-workspace\\credentials"
$env:AWS_PROFILE = "questionbank"
```

**Git Bash:**
```bash
export AWS_CONFIG_FILE=./.aws-workspace/config
export AWS_SHARED_CREDENTIALS_FILE=./.aws-workspace/credentials
export AWS_PROFILE=questionbank
```

**Step 5: Verify Configuration**
```bash
aws configure list-profiles
aws sts get-caller-identity
```
{{% /notice %}}

___

#### Build and Push Container Images

1\. **Copy the repository URI**: In your ECR repository page, copy the **URI** of the repository. You'll need this for pushing container images.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-22-14.png)

2\. **Open Docker Desktop**: Click on **Docker Desktop** in the start menu in the computer.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-21-33.png)

3\. **Open terminal**: Enter `aws configure`.

- **AWS Access Key ID**: Enter the access key ID you copied earlier
- **AWS Secret Access Key**: Enter the secret access key you copied earlier
- **Default region name**: Enter `ap-southeast-1`
- **Default output format**: Enter `json`

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/.png)

3\. **Open terminal and configure AWS CLI**: Enter the information copied from Step 3.

```bash
aws configure
```

- **AWS Access Key ID**: Enter the access key ID you copied earlier
- **AWS Secret Access Key**: Enter the secret access key you copied earlier
- **Default region name**: Enter `ap-southeast-1`
- **Default output format**: Enter `json`

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/.png)

##### **Building and Pushing the Application Image**

4\. **Set environment variables**: Configure your AWS and ECR variables for easier command execution.

**PowerShell:**
```powershell
$AWS_REGION = "ap-southeast-1"
$AWS_ACCOUNT_ID = "<YOUR_ACCOUNT_ID>"   # Replace with your account ID (e.g., 727646479508)
$ECR_REGISTRY = "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
$ECR_REPO = "questionbank-app"
$IMAGE_TAG = "latest"
```

**Git Bash:**
```bash
export AWS_REGION="ap-southeast-1"
export AWS_ACCOUNT_ID="<YOUR_ACCOUNT_ID>"   # Replace with your account ID
export ECR_REGISTRY="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
export ECR_REPO="questionbank-app"
export IMAGE_TAG="latest"
```

5\. **Authenticate with ECR**: Execute the following command to authenticate Docker with your ECR registry.

**PowerShell:**
```powershell
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
```

**Git Bash:**
```bash
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
```

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-35-47.png)

6\. **Build the application image**: Build the Docker image from your backend application.

**PowerShell:**
```powershell
docker build -t "$($ECR_REPO):$IMAGE_TAG" -f backend/Dockerfile backend
```

**Git Bash:**
```bash
docker build -t "$ECR_REPO:$IMAGE_TAG" -f backend/Dockerfile backend
```

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-38-14.png)

7\. **Tag the image for ECR**: Tag your local image with the ECR repository URI.

**PowerShell:**
```powershell
docker tag "$($ECR_REPO):$IMAGE_TAG" "$ECR_REGISTRY/$($ECR_REPO):$IMAGE_TAG"
```

**Git Bash:**
```bash
docker tag "$ECR_REPO:$IMAGE_TAG" "$ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG"
```

8\. **Push the image to ECR**: Upload your image to the ECR repository.

**PowerShell:**
```powershell
docker push "$ECR_REGISTRY/$($ECR_REPO):$IMAGE_TAG"
```

**Git Bash:**
```bash
docker push "$ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG"
```

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-39-14.png)

9\. **Verify your image**: Return to the ECR console and refresh your repository. You should see your image with the `latest` tag.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-40-02.png)

You have successfully built and pushed your container image to Amazon ECR. The image is now ready to be deployed

10\. **Verify your images**: Return to the ECR console and refresh your repository. You should see both images with their respective tags.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.2/2025-08-12_19-40-02.png)


Both images are now ready to be deployed to Amazon ECS.

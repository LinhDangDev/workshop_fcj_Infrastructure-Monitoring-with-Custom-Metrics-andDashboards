---
title : "Define the Task Role and Task Execution Role "
date: "2025-08-12"
weight : 4
chapter : false
pre : " <b> 3.4 </b> "
---

#### Task Role vs. Task Execution Role

**Amazon ECS uses two distinct IAM roles** for managing containerized applications: the **Task Role** and the **Task Execution Role**. Understanding the difference between these roles is essential for proper security configuration.

| Aspect | Task Role | Task Execution Role |
|--------|-----------|-------------------|
| **Purpose** | Provides permissions for your **application code** | Provides permissions for **ECS service** to manage tasks |
| **Who Uses It** | Your **application containers** | **ECS/Fargate agents** |
| **When Applied** | During **application runtime** | During **task preparation and lifecycle** |
| **Common Use Cases** |  Access S3 buckets<br>• Read/Write DynamoDB<br>• Invoke Lambda functions<br> Access other AWS services | Pull container images from ECR<br> Send logs to CloudWatch<br> Retrieve secrets from Secrets Manager<br>• Create log groups |
| **Required When** | Your app makes **AWS API calls** | Using **private ECR** or **CloudWatch logging** |

##### **Task Role (Application Permissions)**
This IAM role is **assumed by your application code** running inside the containers. It grants your application the ability to interact with AWS services directly. For example:
- Reading configuration files from S3
- Storing user data in DynamoDB
- Sending notifications via SNS

##### **Task Execution Role (Infrastructure Permissions)**
This IAM role is **used by ECS/Fargate** to set up and manage your tasks. It handles infrastructure-level operations required before your application starts and during its lifecycle:
- Downloading container images from private repositories
- Injecting secrets into container environment variables
- Streaming application logs to monitoring services

**Key Difference**: Think of the Task Execution Role as "what ECS needs to run your container" and the Task Role as "what your application needs to do its job."

___

#### Create Task Execution Role and Task Role

{{% notice warning %}}
**Important Security Note**: In this workshop, for simplicity, we will attach AWS-managed policies to this role. However, in a production environment, you should always create custom IAM policies that grant only the specific permissions required (the principle of least privilege). This minimizes potential security risks.
{{% /notice %}}

1\. Navigate to IAM:
   - In the AWS Console search bar, type `IAM`
   - Select **IAM** from the dropdown

![image](/images/3.4/2025-08-12_19-54-25.png)

2\. In the IAM Dashboard, select **Roles** from the left navigation panel, then click **Create role**.

![image](/images/3.4/2025-08-12_19-57-04.png)

3\. Configure the trusted entity:
   - **Trusted entity type**: Select **AWS service**
   - **Service or use case**: Select **Elastic Container Service**
   - **Use case**: Select **Elastic Container Service Task**
   - Click **Next**

![image](/images/3.4/2025-08-12_19-58-39.png)

4\. Attach the required policies by searching for and selecting each one:
   - **AmazonECSTaskExecutionRolePolicy** (Essential for ECS task execution)
   - **AmazonEC2ContainerRegistryReadOnly** (For pulling images from ECR)
   - **CloudWatchLogsFullAccess** (For sending logs to CloudWatch)
   - **SecretsManagerReadWrite** (For accessing password user database)

After selecting all four policies, click **Next**.

![image](/images/3.4/2025-08-12_20-00-44.png)
![image](/images/3.4/2025-08-12_20-01-09.png)


5\. Configure the role details:
   - **Role name**: Enter `QuestionBank-ECS-TaskExecutionRole`
   - Review the attached policies to ensure all four are included
   - Click **Create role**

6\. Do the following steps to create the Task Role:
   - **AmazonRDSReadOnlyAccess** (For accessing the database)
   - **AmazonSSMReadOnlyAccess** (For accessing the database)
   - **CloudWatchLogsFullAccess** (For sending logs to CloudWatch)
   - **SecretsManagerReadWrite** (For accessing password user database)

7\. Configure the role details:
   - **Role name**: Enter `QuestionBank-ECS-TaskRole`
   - Review the attached policies to ensure all four are included
   - Click **Create role**


6\. **Verify creation**: Confirm that the **QuestionBank-ECS-TaskRole** and **QuestionBank-ECS-TaskExecutionRole** appears in your roles list with all four policies attached.

Your Task Execution Role is now ready to be used in your ECS task definitions. This role provides the necessary permissions for Fargate to manage your containerized applications.

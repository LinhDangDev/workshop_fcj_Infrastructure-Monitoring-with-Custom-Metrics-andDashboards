---
title : "Cleanup"
date: "2025-08-12"
weight : 5
chapter : false
pre : " <b> 5. </b> "
---

#### Cleanup AWS Resources in Proper Order

{{% notice warning %}}
**Important**: Follow the cleanup steps in the exact order provided to avoid dependency conflicts. Some resources cannot be deleted if other resources are still using them.
{{% /notice %}}

## Phase 1: Application Layer Cleanup

#### Step 1: Stop and Delete ECS Services

1\. Navigate to **Amazon Elastic Container Service (ECS)** in the AWS Console.

![image](/images/5.1/2025-08-12_21-31-53.png)

2\. Select your **QuestionBank-ECS-Cluster**.

![image](/images/5.1/2025-08-12_21-33-52.png)

3\. In the **Services** tab, select all running services and click **Delete**.

![image](/images/5.1/2025-08-12_21-34-22.png)

4\. Confirm the deletion by typing **delete** and click **Delete**.

![image](/images/5.1/2025-08-12_21-35-35.png)

5\. Wait for all services to be deleted before proceeding to the next step.

![image](/images/5.1/2025-08-12_21-37-04.png)

#### Step 2: Delete ECS Task Definitions

6\. In the left navigation pane, select **Task definitions**.

![image](/images/5.1/2025-08-12_21-37-35.png)

7\. Select your task definitions (e.g., `questionbank-app`) and click **Actions** → **Deregister**.

![image](/images/5.1/2025-08-12_21-38-30.png)

8\. Confirm the deregistration.

![image](/images/5.1/2025-08-12_21-39-20.png)

## Phase 2: Load Balancer and Networking Cleanup

#### Step 3: Delete Application Load Balancer

9\. Navigate to **EC2** → **Load Balancers** in the AWS Console.

![image](/images/5.1/2025-08-12_21-40-23.png)

10\. Select your **QuestionBank Load Balancer** and click **Actions** → **Delete**.

![image](/images/5.1/2025-08-12_21-40-23.png)

11\. Confirm the deletion by typing the load balancer name.

![image](/images/5.1/2025-08-12_21-41-22.png)

#### Step 4: Delete Target Groups

12\. Navigate to **Target Groups** in the EC2 console.

![image](/images/5.1/2025-08-12_21-42-09.png)

13\. Select all QuestionBank-related target groups and click **Actions** → **Delete**.

![image](/images/5.1/2025-08-12_21-42-09.png)

14\. Confirm the deletion.

![image](/images/5.1/2025-08-12_21-42-54.png)

## Phase 3: Database and Cache Cleanup

#### Step 5: Delete RDS Database

15\. Navigate to **Amazon RDS** in the AWS Console.

![image](/images/5.1/2025-08-12_21-43-41.png)

16\. Select your **QuestionBank database** and click **Actions** → **Delete**.

![image](/images/5.1/2025-08-12_21-44-16.png)

17\. Configure deletion settings:
    - **Create final snapshot**: Uncheck (unless you want to keep a backup)
    - **Retain automated backups**: Uncheck
    - Type **delete me** to confirm

![image](/images/5.1/2025-08-12_21-44-50.png)

18\. Click **Delete DB instance**.

![image](/images/5.1/2025-08-12_21-44-50.png)


## Phase 4: Container and Monitoring Cleanup

#### Step 6: Delete ECR Repository

19\. Navigate to **Amazon Elastic Container Registry (ECR)**.

![image](/images/5.1/2025-08-12_21-47-11.png)

20\. Select your **questionbank-app** repository and click **Delete**.

![image](/images/5.1/2025-08-12_21-47-11.png)

21\. Confirm the deletion by typing **delete**.

![image](/images/5.1/2025-08-12_21-48-06.png)

#### Step 9: Delete CloudWatch Resources

22\. Navigate to **Amazon CloudWatch**.

![image](/images/5.1/2025-08-12_21-48-38.png)

23\. Delete **Custom Dashboards**:
    - Select **Dashboards** → Select your custom dashboards → **Delete**

![image](/images/5.1/2025-08-12_21-49-42.png)



## Phase 5: Security and Access Cleanup

#### Step 7: Delete IAM Roles and Policies

24\. Navigate to **IAM (Identity and Access Management)**.

![image](/images/5.1/2025-08-12_21-52-07.png)

25\. Delete **IAM Roles**:
    - Select **Roles** → Find QuestionBank-related roles → **Delete**

![image](/images/5.1/2025-08-12_21-53-21.png)
![image](/images/5.1/2025-08-12_21-54-15.png)

#### Step 8: Delete Security Groups

26\. Navigate to **EC2** → **Security Groups**.

![image](/images/5.1/2025-08-12_21-55-29.png)

27\. Select QuestionBank-related security groups and click **Actions** → **Delete security groups**.

![image](/images/5.1/2025-08-12_21-56-23.png)

28\. Confirm the deletion.


## Phase 6: Network Infrastructure Cleanup

#### Step 9: Delete NAT Gateways

29\. Navigate to **VPC** → **NAT Gateways**.

![image](/images/5.1/2025-08-12_21-58-44.png)

30\. Select your NAT Gateways and click **Actions** → **Delete NAT gateway**.

![image](/images/5.1/2025-08-12_21-59-24.png)

31\. Confirm the deletion.

![image](/images/5.1/2025-08-12_21-59-24.png)

#### Step 10: Release Elastic IP Addresses

33\. Navigate to **EC2** → **Elastic IPs**.

![image](/images/5.1/2025-08-12_22-01-21.png)

34\. Select unused Elastic IP addresses and click **Actions** → **Release Elastic IP addresses**.

![image](/images/5.1/2025-08-12_22-01-21.png)

35\. Confirm the release.

![image](/images/5.1/2025-08-12_22-02-17.png)

#### Step 11: Delete VPC Components

36\. Navigate to **VPC** → **Route Tables**.

![image](/images/5.1/2025-08-12_22-03-16.png)

37\. Delete custom route tables (keep the main route table):
    - Select custom route tables → **Actions** → **Delete route table**

![image](/images/5.1/2025-08-12_22-03-16.png)

38\. Navigate to **Subnets** and delete custom subnets:
    - Select QuestionBank subnets → **Actions** → **Delete subnet**

![image](/images/5.1/2025-08-12_22-04-15.png)

39\. Navigate to **Internet Gateways** and detach/delete:
    - Select your Internet Gateway → **Actions** → **Detach from VPC**
    - Then **Actions** → **Delete internet gateway**

![image](/images/5.1/2025-08-12_22-08-01.png)
![image](/images/5.1/2025-08-12_22-08-26.png)

#### Step 12: Delete VPC

40\. Finally, navigate to **VPCs** and delete your custom VPC:
    - Select your QuestionBank VPC → **Actions** → **Delete VPC**

41\. Confirm the deletion by typing **delete**.

![image](/images/5.1/2025-08-12_22-09-17.png)


## Verification

#### Step 13: Verify Complete Cleanup

42\. Check each service to ensure all resources have been deleted:
    - **ECS**: No clusters, services, or task definitions
    - **RDS**: No databases
    - **ElastiCache**: No clusters
    - **EC2**: No load balancers, target groups, or security groups
    - **VPC**: No custom VPCs, subnets, or gateways
    - **IAM**: No custom roles or policies
    - **ECR**: No repositories
    - **CloudWatch**: No custom dashboards or alarms

{{% notice info %}}
**Cleanup Complete**: All AWS resources for the QuestionBank project have been successfully removed. This will stop all charges associated with these resources.
{{% /notice %}}

{{% notice tip %}}
**Cost Verification**: Check your AWS billing dashboard after 24 hours to confirm that all charges have stopped.
{{% /notice %}}

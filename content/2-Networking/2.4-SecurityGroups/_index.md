---
title : "Create Security Groups"
date: "2025-08-12"
weight : 4
chapter : false
pre : " <b> 2.4 </b> "
---

___

#### Create Security Group for Public Subnets

1\. In the VPC Dashboard, under **Security** in the left navigation panel, select **Security groups**.

![image](/images/2.4/2025-08-12_16-31-03.png)

2\. Click **Create security group**.

![image](/images/2.4/2025-08-12_16-33-16.png)

3\. Configure the basic settings:
   - **Security group name**: Enter `fcj-public-sg`
   - **Description**: Enter `Allows inbound HTTP 80, 81 from the internet`
   - **VPC**: Select **fcj-vpc-monitoring**


![image](/images/2.4/2025-08-12_16-34-43.png)
4\. Add the first inbound rule for the core application:
   - Click **Add rule**
   - **Type**: Select **HTTP**
   - **Source**: Select **Anywhere-IPv4**

   This rule allows all inbound HTTP traffic from the internet through port 80.
![image](/images/2.4/2025-08-12_16-34-43.png)
5\. Add the second inbound rule for the admin application:
   - Click **Add rule**
   - **Type**: Select **Custom TCP**
   - **Port range**: Enter `81`
   - **Source**: Select **Anywhere-IPv4**

   This rule allows access to the admin application through port 81.

![image](/images/2.4/2025-08-12_16-35-58.png)

6\. Scroll down and click **Create security group**.

7\. **Verify creation**: Confirm that the **fcj-public-sg** security group appears in your list with the correct inbound rules configured.
___

#### Create Security Group for Private Subnets

This security group will allow all inbound traffic from the public subnets security group, implementing the principle of least privilege by only allowing access from authorized sources.

1\. In the VPC Dashboard, under **Security** in the left navigation panel, select **Security groups**.

2\. Click **Create security group**.

3\. Configure the basic settings:
   - **Security group name**: Enter `fcj-private-sg`
   - **Description**: Enter `Allows all inbound traffic from fcj-public-sg`
   - **VPC**: Select **fcj-vpc-monitoring**

![image](/images/2.4/2025-08-12_16-40-49.png)

4\. Add the inbound rule:

   - Click **Add rule**
   - **Type**: Select **All traffic**
   - **Source**: Select **Custom**, then choose **fcj-public-sg**

This rule allows all traffic from resources in the public security group to reach private subnet resources.

![image](/images/2.4/2025-08-12_16-41-58.png)

5\. Scroll down and click **Create security group**.

6\. **Verify creation**: Confirm that the **fcj-private-sg** security group appears in your list with the correct inbound rule from **fcj-public-sg**.
___

{{% notice tip %}}
Follow the steps above and use the configuration information below to continue creating Security Groups for each component.
{{% /notice %}}

#### Create ALB Security Group
   ```
   Name: FCJ-ALB-SG
   Description: Security group for Application Load Balancer
   VPC: fcj-vpc-monitoring-vpc

   Inbound Rules:
   - Type: HTTP, Port: 80, Source: 0.0.0.0/0
   - Type: HTTPS, Port: 443, Source: 0.0.0.0/0

   Outbound Rules: (Default - All traffic)
   ```

#### Create ECS Security Group
   ```
   Name: FCJ-ECS-SG
   Description: Security group for ECS tasks
   VPC: fcj-vpc-monitoring

   Inbound Rules:
   - Type: Custom TCP, Port: 3000, Source: FCJ-ALB-SG

   Outbound Rules: (Default - All traffic)
   ```

#### Create Lambda Security Group
   ```
   Name: FCJ-Lambda-SG
   Description: Security group for Lambda functions
   VPC: fcj-vpc-monitoring

   Inbound Rules: None needed

   Outbound Rules:
   - Type: HTTPS, Port: 443, Destination: 0.0.0.0/0
   ```

#### Create RDS Security Group
   ```
   Name: FCJ-RDS-SG
   Description: Security group for RDS database
   VPC: fcj-vpc-monitoring

   Inbound Rules:
   - Type: MS SQL, Port: 1433, Source: FCJ-ECS-SG
   - Type: MS SQL, Port: 1433, Source: FCJ-Lambda-SG

   Outbound Rules: None needed
   ```

#### (Optional) **Create ElastiCache Security Group:**
   ```
   Name: FCJ-Cache-SG

   Description: Security group for ElastiCache
   VPC: fcj-vpc-monitoring

   Inbound Rules:
   - Type: Custom TCP, Port: 6379, Source: FCJ-ECS-SG
   - Type: Custom TCP, Port: 6379, Source: FCJ-Lambda-SG

   Outbound Rules: None needed
   ```

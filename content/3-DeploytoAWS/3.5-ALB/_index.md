---
title : "Implement Load Balancing for Core Application"
date: "2025-08-12"
weight : 5
chapter : false
pre : " <b> 3.5 </b> "
---

#### Application Load Balancer Overview

An **Application Load Balancer (ALB)** is a smart traffic distributor that works at the **application layer (Layer 7)** of networking. Think of it as an intelligent receptionist that decides where to send visitors in a large office building.

**How ALB Works:**
When a user visits your website, their request first arrives at the ALB. The ALB then:
1. **Examines the request** (looking at details like the URL path, headers, etc.)
2. **Applies routing rules** to decide which server should handle this request
3. **Forwards the request** to the most appropriate healthy server
4. **Returns the response** back to the user

**Key Benefits for Your Application:**

- **High Availability**: If one server fails, ALB automatically stops sending traffic to it and routes requests to healthy servers instead
- **Auto Scaling**: ALB can handle traffic spikes automatically - you don't need to worry about capacity planning
- **Health Monitoring**: ALB continuously checks if your servers are working properly by sending health check requests
- **Flexible Routing**: You can set up rules to send different types of requests to different servers (e.g., API requests to one group, web pages to another)

**Real-World Example:**
Imagine you run an online store with multiple servers:
- Server A handles product listings
- Server B processes payments
- Server C manages user accounts

Your ALB can be configured to:
- Send requests to `/products/*` → Server A
- Send requests to `/payment/*` → Server B
- Send requests to `/account/*` → Server C

If Server B goes down, ALB detects this and can temporarily route payment requests to a backup server, ensuring your store stays operational.


___

#### Create the Core Application Target Group

Target groups are essential for routing requests to your registered resources, like EC2 instances, Lambda functions, or IP addresses. They use the protocol and port you define for this routing, and a single target can be registered with multiple target groups if needed.

For our AWS Fargate tasks, we will create a **target group of type IP addresses**. This is because **tasks launched using AWS Fargate** are associated with an elastic network interface (ENI) and **receive their own IP address**, rather than running on an underlying Amazon EC2 instance managed by you.

1\. Navigate to EC2:
   - In the AWS Console search bar, type `EC2`
   - Select **EC2** from the dropdown

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-09-24.png)

2\. In the EC2 Dashboard, scroll down in the left navigation panel to **Load Balancing** and select **Target groups**. Click **Create target group**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-10-58.png)

3\. Configure the target type:
   - **Target type**: Select **IP addresses**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-13-01.png)

4\. Configure basic settings:
   - **Target group name**: Enter `QuestionBank-EC2-tg`
   - **Protocol**: Select **HTTP**
   - **Port**: Enter `3001`
   - **VPC**: Select **FCJ-vpc-monitoring**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-13-01.png)
![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-14-45.png)

5\. Configure health checks:
   - **Health check path**: Enter `/health`

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-15-37.png)

6\. Expand **Advanced health check settings**:
   - **Unhealthy threshold**: Change to `5`
   - Leave other settings as default

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-17-38.png)
![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-18-07.png)

7\. Click **Next** to proceed to target registration.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-19-34.png)

8\. Skip target registration for now (we'll register targets when we create ECS services) and click **Create target group**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-20-07.png)

9\. **Verify creation**: Confirm that **QuestionBank-EC2-tg** appears in your target groups list.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-23-12.png)
___

#### Create the Application Load Balancer

1\. In the EC2 Dashboard, under **Load Balancing**, select **Load Balancers** and click **Create load balancer**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-24-43.png)
![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-25-12.png)

2\. Select **Application Load Balancer** and click **Create**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-25-41.png)

3\. Configure basic settings:
  - **Load balancer name**: Enter `Questionbank-ALB`
  - **Scheme**: Select **Internet-facing**
  - **IP address type**: Leave as **IPv4**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-27-15.png)

4\. Configure network mapping:

  - **VPC**: Select **fcj-vpc**
  - **Availability Zones**: Select both AZs and their respective public subnets:
  - **fcj-public-public1-ap-southeast-01**
  - **fcj-public-public2-ap-southeast-02**


![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-31-42.png)


5\. Configure security:
  - **Security groups**: Select **QuestionBank-ALB-SG**
  - Remove the default security group if present

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-33-27.png)

6\. Configure listeners and routing:
  - **Protocol**: HTTP
  - **Port**: 80
  - **Default action**: Forward to **QuestionBank-EC2-tg**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-34-25.png)

7\. Review all information and click **Create load balancer**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.5/2025-08-12_20-37-28.png)

8\. **Verify creation**: Wait for the load balancer to become "Active" and note the DNS name for later use.

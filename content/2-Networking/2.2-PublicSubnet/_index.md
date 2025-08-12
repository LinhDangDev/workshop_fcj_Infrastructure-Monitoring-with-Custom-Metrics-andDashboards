---
title : "Create Public Subnets"
date: "2025-08-12"
weight : 2
chapter : false
pre : " <b> 2.2 </b> "
---
___

#### Create Internet Gateway

1\. In the VPC Dashboard, select **Internet gateways** from the left navigation panel, then click **Create internet gateway**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/1.png)

2\. Configure the Internet Gateway:
   - **Name tag**: Enter `fcj-igw`
   - Click **Create internet gateway**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/11.png)

3\. After creation, you'll see the new Internet Gateway in a "Detached" state. Click **Actions**, then select **Attach to VPC**.

4\. Configure the VPC attachment:
   - **Available VPCs**: Select **fcj-vpc-monitoring**
   - Click **Attach internet gateway**

5\. **Verify attachment**: The Internet Gateway status should change to "Attached" and show it's connected to **fcj-vpc**.
___

#### Create Public Route Table


1\. In the VPC Dashboard, select **Route tables** from the left navigation panel and click **Create route table**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-40-17.png)
![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-44-16.png)

2\. Configure the route table:
   - **Name tag**: Enter `fc    j-route-table`
   - **VPC**: Select **fcj-vpc**
   - Click **Create route table**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-45-29.png)


3\. After creation, select the new route table and click **Edit routes**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-48-07.png)

4\. Add the internet route:
   - Click **Add route**
   - **Destination**: Enter `0.0.0.0/0`
   - **Target**: Select **Internet Gateway**, then choose **fcj-igw**
   - Click **Save changes**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-47-28.png)

5\. Associate the route table with public subnets by clicking **Actions**, then **Edit subnet associations**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-59-45.png)

6\. Select the public subnets:
   - Check **fcj-subnet-public1-ap-southeast-1a**
   - Check **fcj-subnet-public1-ap-southeast-1b**
   - Click **Save associations**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/2.2/2025-08-12_15-58-42.png)

7\. **Verify configuration**: Confirm that both public subnets are now associated with the **fcj-route-table** and that the route table contains both the local route (10.10.0.0/16) and the internet route (0.0.0.0/0).

{{% notice info %}}
Your public subnets are now properly configured with internet access. Resources deployed in these subnets with public IP addresses can now communicate with the internet through the Internet Gateway.
{{% /notice %}}

---
title : "Create Private Subnets"
date: "2025-08-12"
weight : 3
chapter : false
pre : " <b> 2.3 </b> "
---
___

#### Create NAT Gateway

1\. In the VPC Dashboard, select **NAT gateways** from the left navigation panel and click **Create NAT gateway**.

![image](/images/2.3/2025-08-12_16-08-13.png)
![image](/images/2.3/2025-08-12_16-08-50.png)
2\. Configure the NAT Gateway:
   - **Name**: Enter `fcj-ngw`
   - **Subnet**: Select **fcj-subnet-public1-ap-southeast-1a** (NAT gateway must be in a public subnet)

![image](/images/2.3/2025-08-12_16-11-35.png)

3\. Create the Elastic IP:
   - **Connectivity type**: Ensure **Public** is selected
   - **Elastic IP allocation ID**: Click **Allocate Elastic IP** to create a new public IP address
   - Click **Create NAT gateway**


4\. **Verify creation**: The NAT gateway will show a status of "Pending" initially, then change to "Available" once ready. Note the assigned Elastic IP address.

___

#### Create Private Route Table

Next, we will configure our private route table to route outbound traffic from the private subnets (and also the database subnets, as they are private too) through the NAT gateway.

1\. In the VPC Dashboard, select **Route tables** from the left navigation panel and click **Create route table**.

![image](/images/2.3/2025-08-12_16-15-57.png)

2\. Create the route table:
   - **Name tag**: Enter `fcj-private-rtb`
   - **VPC**: Select **fcj-vpc**
   - Click **Create route table**

![image](/images/2.3/2025-08-12_16-17-09.png)

3\. After creation, select the new route table and click **Edit routes**.

![image](/images/2.3/2025-08-12_16-18-02.png)

4\. Add the NAT gateway route:
   - Click **Add route**
   - **Destination**: Enter `0.0.0.0/0`
   - **Target**: Select **NAT Gateway**, then choose **fcj-ngw**
   - Click **Save changes**

![image](/images/2.3/2025-08-12_16-18-57.png)

5\. Associate the route table with private subnets by clicking **Actions**, then **Edit subnet associations**.

![image](/images/2.3/2025-08-12_16-19-52.png)

6\. Select all private and database subnets:
   - Check **fcj-subnet-private1-ap-southeast-1a**
   - Check **fcj-subnet-private2-ap-southeast-1b**
   - Check **fcj-DB-Subnet-1**
   - Check **fcj-DB-Subnet-2**
   - Check **fcj-Cache-Subnet-1**
   - Check **fcj-Cache-Subnet-2**
   - Click **Save associations**

![image](/images/2.3/2025-08-12_16-20-46.png)

7\. **Verify configuration**: Confirm that all four subnets are now associated with the **fcj-private-rtb** and that the route table contains both the local route (10.10.0.0/16) and the NAT gateway route (0.0.0.0/0).

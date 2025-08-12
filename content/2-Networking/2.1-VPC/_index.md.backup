---
title : "Create VPC and Subnets"
date: "2025-08-12"
weight : 1
chapter : false
pre : " <b> 2.1 </b> "
---

#### Create VPC

1\. Log in to the [AWS Console](https://console.aws.amazon.com/). **Choose a region closest to your location** (e.g., `us-east-1` for US East Coast or `ap-southeast-1` for Singapore) to minimize latency and optimize costs. Make note of your selected region as you'll need to use the same region throughout this workshop. For this example, we'll use Singapore (`ap-southeast-1`).

![image](/images/2.1/1.png)



2\. In search bar, type `VPC` and select **VPC** from the dropdown.

{{% notice tip %}}
You should click the star icon to bookmark VPC for faster access next time without having to search for it.
{{% /notice %}}

![image](/images/2.1/2.png)

3\. In the VPC Dashboard, select **Your VPCs** from the left navigation panel, then click **Create VPC**.

![image](/images/2.1/3.png)

4\. Configure the VPC settings:
   - **Resources to create**: Select **VPC only**
   - **Name tag**: Enter `FCJ-vpc-monitoring`
   - **IPv4 CIDR block**: Enter `10.0.0.0/16`
   - **IPv6 CIDR block**: Leave as **No IPv6 CIDR block**
   - **Tenancy**: Leave as **Default**

![image](/images/2.1/4.png)

5\. Review your settings and click **Create VPC**.

![image](/images/2.1/5.png)

6\. **Verify creation**: You should see a success message. The new VPC **FCJ-vpc-monitoring** should appear in your VPC list with the CIDR block **10.0.0.0/16**.

___

#### Add Subnets

| Subnet name                                   | CIDR          |
| --------------------------------------------- | ------------- |
| fcj-Cache-Subnet-1                   | 10.0.210.0/24 |
| fcj-Cache-Subnet-2                   | 10.0.211.0/24 |
| fcj-DB-Subnet-1                      | 10.0.200.0/24 |
| fcj-DB-Subnet-1                      | 10.0.201.0/24 |
| fcj-subnet-private1-ap-southeast-1a  | 10.0.128.0/20 |
| fcj-subnet-private2-ap-southeast-1b  | 10.0.144.0/20 |
| fcj-subnet-public1-ap-southeast-1a   | 10.0.0.0/20   |
| fcj-subnet-public1-ap-southeast-1b   | 10.0.16.0/20  |


Let's create these subnets.

___

##### **Public Subnets**

1\. In the VPC Dashboard, select **Subnets** from the left navigation panel and click **Create subnet**.

![image](/images/2.1/6.png)
![image](/images/2.1/6_5.png)


2\. Configure the first public subnet:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter ` fcj-subnet-public1`
   - **Availability Zone**: Choose the **first AZ** (e.g., ap-southeast-1a)
   - **IPv4 subnet CIDR block**: Enter `10.0.0.0/20`

![image](/images/2.1/7.png)


3\. Scroll down and click **Create subnet**.

![image](/images/2.1/8.png)

4\. **Create the second public subnet** by clicking **Create subnet** again and configure:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-subnet-public1`
   - **Availability Zone**: Choose the **seccond AZ** (e.g., ap-southeast-1b)
   - **IPv4 subnet CIDR block**: Enter `10.0.16.0/20`

![image](/images/2.1/9.png)

5\. Scroll down and click **Create subnet**.

{{% notice note %}}
Continue do the same Public Subnets
{{% /notice %}}


___

##### **Private Subnets**

1\. In the VPC Dashboard, select **Subnets** from the left navigation panel and click **Create subnet**.

2\. Configure the first private subnet:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-subnet-private1-ap-southeast-1a`
   - **Availability Zone**: Choose the **first AZ** (e.g., ap-southeast-1a)
   - **IPv4 subnet CIDR block**: Enter `10.0.128.0/20`

3\. Scroll down and click **Create subnet**.

4\. **Create the second private subnet** by clicking **Create subnet** again and configure:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-subnet-private2-ap-southeast-1b`
   - **Availability Zone**: Choose the **second AZ** (e.g., ap-southeast-1b)
   - **IPv4 subnet CIDR block**: Enter `10.0.144.0/20`

5\. Scroll down and click **Create subnet**.

___

##### **Database Subnets**

1\. In the VPC Dashboard, select **Subnets** from the left navigation panel and click **Create subnet**.

2\. Configure the first database subnet:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-DB-Subnet-1`
   - **Availability Zone**: Choose the **first AZ** (e.g., ap-southeast-1a)
   - **IPv4 subnet CIDR block**: Enter `10.0.200.0/24`

3\. Scroll down and click **Create subnet**.

4\. **Create the second database subnet** by clicking **Create subnet** again and configure:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-DB-Subnet-2`
   - **Availability Zone**: Choose the **second AZ** (e.g., ap-southeast-1b)
   - **IPv4 subnet CIDR block**: Enter `10.0.201.0/24`

5\. Scroll down and click **Create subnet**.

___

##### **Cache Subnets**

1\. In the VPC Dashboard, select **Subnets** from the left navigation panel and click **Create subnet**.

2\. Configure the first cache subnet:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-Cache-Subnet-1`
   - **Availability Zone**: Choose the **first AZ** (e.g., ap-southeast-1a)
   - **IPv4 subnet CIDR block**: Enter `10.0.210.0/24`

3\. Scroll down and click **Create subnet**.

4\. **Create the second cache subnet** by clicking **Create subnet** again and configure:
   - **VPC ID**: Select **FCJ-vpc-monitoring**
   - **Subnet name**: Enter `fcj-Cache-Subnet-2`
   - **Availability Zone**: Choose the **second AZ** (e.g., ap-southeast-1b)
   - **IPv4 subnet CIDR block**: Enter `10.0.211.0/24`

5\. Scroll down and click **Create subnet**.

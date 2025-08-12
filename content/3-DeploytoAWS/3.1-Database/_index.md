---
title : "Set Up RDS Microsoft SQL Server Database"
date: "2025-08-12"
weight : 1
chapter : false
pre : " <b> 3.1 </b> "
---

#### Amazon RDS Overview

**Amazon Relational Database Service (Amazon RDS)** is a fully managed web service that **simplifies the setup, operation, and scaling of relational databases** in the AWS Cloud. It provides **cost-efficient and resizable capacity** for industry-standard relational databases while automating common database administration tasks.

Amazon RDS offers significant advantages over self-managed database deployments:

- **Multiple Database Engine Support**: Choose from popular engines including IBM Db2, MariaDB, Microsoft SQL Server, MySQL, Oracle Database, and **PostgreSQL** to meet your specific application requirements.
- **Fully Managed Operations**: **Amazon RDS automatically handles critical tasks** including automated backups, software patching, monitoring, failure detection, and recovery, allowing you to focus on application development instead of database maintenance.
- **Scalability and High Availability**: Achieve high availability through Multi-AZ deployments with automatic failover capabilities, and enhance read performance using read replicas for read-heavy workloads.
- **Security and Compliance**: Built-in security features including encryption at rest and in transit, network isolation, and fine-grained access controls.

For production environments, AWS **strongly recommends deploying databases across multiple Availability Zones (AZs)** to ensure maximum resilience and availability. However, **in this workshop, we'll deploy a single database instance** within one subnet in a single AZ to **optimize for cost while demonstrating

___

#### Create Subnet Group

**A database subnet group** is a collection of subnets (typically private) that you create in a VPC and that you then designate for your database instances. By using a database subnet group, **you can specify a particular VPC** when creating database instances.

1\. In the AWS Console search bar, type "RDS" and select **Aurora and RDS** from the dropdown, or navigate to **Services > Database > Aurora and RDS**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-23-26.png)

{{% notice tip %}}
You should click the star icon to bookmark VPC for faster access next time without having to search for it.
{{% /notice %}}

2\. In the RDS Dashboard, select **Subnet groups** from the left navigation panel, then click **Create DB subnet group**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-28-29.png)

3\. Configure the subnet group settings:
   - **Name**: Enter `questionbank-db-subnet-group`
   - **Description**: Enter `questionbank-db-subnet-group`
   - **VPC**: Select **fcj-vpc-monitoring**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-30-10.png)

4\. Configure the Availability Zones and subnets:
   - **Availability Zones**: Select **ap-southeast-1a** and **ap-southeast-1b** (or your region's equivalent AZs)
   - **Subnets**: Choose **fcj-DB-Subnet-1** and **fcj-DB-Subnet-2**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-30-57.png)

5\. Scroll to the bottom and click **Create**.

6\. **Verify creation**: Confirm that the **fcj-db-subnet-group** appears in your subnet groups list with the correct VPC and subnets associated.

___

#### Create Database Instance

1\. In the RDS Dashboard, select **Databases** from the left navigation panel, then click **Create database**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-33-34.png)

2\. Configure the database creation method and engine:
   - **Database creation method**: Select **Standard create**
   - **Engine type**: Select **Microsoft SQL Server**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-34-17.png)

3\.2\. Configure the database creation method and engine:
   - **Database managed type**: Select **Amazon RDS**
   - **Edition**: Select **SQl Server Express Edition**
   - **Engine version**: Choose the SQL Server version that matches your local development environment
   - **Template**: Select **Free tier**


![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-34-54.png)

4\. Credential Settings:
   - **Master username**: Enter `admin`

   - **Credentials management**: Select **Self managed**
   - **Master password**: Enter `QuestionBank2025!`
   - **Confirm master password**: Enter `fQuestionBank2025!`

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-35-51.png)

{{% notice warning %}}
In production environments, use a strong password and consider using AWS Secrets Manager for credential management.
{{% /notice %}}


6\. Configure instance configuration
   - **DB instance class**: Select **db.t3.micro**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-46-14.png)

7\. Storage:
    - **Storage type**: Select **General Purpose SSD gp2**
    - **Size**: Leave as default (20 GB)
    - **Auto scaling**: Enable Auto Scalling

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-46-14.png)

8\. Configure connectivity:
    - **Virtual private cloud (VPC)**: Select **fcj-vpc-monitoring**
    - **Subnet group**: Select **questionbank-db-subnet-group**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-52-17.png)


10\. Review your configuration and click **Create database**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.1/2025-08-12_18-57-38.png)

11\. **Verify creation**: The database will show a status of "Creating" initially. Wait for the status to change to "Available" before proceeding to the next section.

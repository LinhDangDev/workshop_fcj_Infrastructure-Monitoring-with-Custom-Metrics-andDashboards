---
title : "Launch the Core Application"
date: "2025-08-12"
weight : 6
chapter : false
pre : " <b> 3.6 </b> "
---

#### Create the Core Application Task Definition

1\. Navigate to **Amazon Elastic Container Service (ECS)** in the AWS Console.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-42-47.png)

2\. In the left navigation pane, select **Task definitions**, then click **Create new task definition**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-43-34.png)
![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-43-48.png)

3\. Configure the basic settings:
   - **Task definition family**: `questionbank-app`
   - **Launch type**: **AWS Fargate**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-44-30.png)

4\. Set the resource allocation:
   - **CPU**: **1 vCPU**
   - **Memory**: **3 GB**

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-44-30.png)

5\. For **Task role**, select **QuestionBank-ECS-TaskRole** and **Task execution role**, select **QuestionBank-ECS-TaskExecutionRole**.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-44-30.png)

6\. **Open a new browser tab** and navigate to **Amazon ECR**. Locate your **fcj-registry** repository and copy the **core** image URI.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-45-32.png)

7\. Return to the **Create new task definition** tab. In the **Container details** section, configure:
   - **Name**: `questionbank-containner`
   - **Image URI**: Paste the **core image URI** you copied from ECR

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-46-13.png)

8\. Configure the container networking:
   - **Container port**: `3001`

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-46-13.png)

9\. Monitoring

- **Trace Collection**: Use Trace Collection
- **Metric collection**: Use Metrics Collection
Click Amazon CloudWatch


![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-50-11.png)

10\. Click **Create** to finalize the task definition.

![image](/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/3.6/2025-08-12_20-50-11.png)

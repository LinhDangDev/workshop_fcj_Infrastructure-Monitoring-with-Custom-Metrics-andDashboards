---
title : "Cloud Watch Monitoring"
date: "2025-08-12"
weight : 4
chapter : false
pre : " <b> 4. </b> "
---

#### Setting Up CloudWatch Monitoring and Custom Dashboards

1\. Navigate to **Amazon CloudWatch** in the AWS Console.

![image](/images/4.1/2025-08-12_21-09-19.png)

2\. In the left navigation pane, select **Dashboards**, then click **Create dashboard**.

![image](/images/4.1/2025-08-12_21-09-19.png)

3\. Configure the dashboard settings:
   - **Dashboard name**: `MonitoringQuestionBank`
   - Click **Create dashboard**

![image](/images/4.1/2025-08-12_21-09-42.png)

4\. In the **Add widget** dialog, select your preferred widget type:
   - **Line**: For time-series data visualization
   - **Number**: For single metric value display
   - **Stacked area**: For cumulative metrics view
   - **Gauge**: For threshold-based monitoring
   - **Bar**: For comparative data analysis
   - **Pie**: For proportional data representation
   - **Explorer**: For multi-dimensional analysis

![image](/images/4.1/2025-08-12_21-10-04.png)

5\. Click **Next** to proceed to metric configuration.

![image](/images/4.1/2025-08-12_21-10-27.png)

#### Adding ECS Container Metrics

6\. In the **Add metric graph** section, configure the data source:
   - Select **Browse** tab
   - Choose **AWS/ECS** from the service list

![image](/images/4.1/2025-08-12_21-11-17.png)

7\. Select the ECS metrics for your QuestionBank application:
   - **CPUUtilization**: Monitor CPU usage
   - **MemoryUtilization**: Track memory consumption
   - Select metrics for your **QuestionBank ECS Cluster**

![image](/images/4.1/2025-08-12_21-11-17.png)

8\. Configure additional container insights metrics:
   - Navigate to **ECS/ContainerInsights** namespace
   - Select relevant metrics for detailed container monitoring

![image](/images/4.1/2025-08-12_21-12-59.png)

#### Adding Custom Metrics and Multi-Service Monitoring

9\. Add metrics from other AWS services by selecting appropriate namespaces:
   - **AWS/ApplicationELB**: For load balancer metrics
   - **AWS/RDS**: For database performance
   - **AWS/ElastiCache**: For cache performance
   - **AWS/Kinesis/Firehose**: For data pipeline monitoring

10\. Configure custom metrics if available:
    - Select **Custom namespaces** if you have application-specific metrics
    - Choose relevant custom metrics for your QuestionBank application

#### Finalizing Dashboard Configuration

11\. Review your selected metrics and click **Create widget**.

![image](/images/4.1/2025-08-12_21-11-17.png)

12\. Your dashboard will display the configured metrics with real-time data visualization.

![image](/images/4.1/2025-08-12_21-12-59.png)

13\. **Save the dashboard** by clicking **Save dashboard** in the top-right corner.

![image](/images/4.1/2025-08-12_21-12-59.png)

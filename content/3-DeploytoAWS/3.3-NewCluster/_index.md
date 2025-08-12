---
title : "Create Amazon ECS Cluster"
date: "2025-08-12"
weight : 3
chapter : false
pre : " <b> 3.3 </b> "
---

1\. Navigate to Amazon ECS:
   - In the AWS Console search bar, type `ECS`
   - Select **Elastic Container Service** from the dropdown

![image](/images/3.3/2025-08-12_19-43-33.png)

2\. In the ECS Dashboard, select **Clusters** from the left navigation panel, then click **Create cluster**.

![image](/images/3.3/2025-08-12_19-42-22.png)

3\. Configure the cluster settings:
   - **Cluster name**: Enter `QuestionBank-ECS-Cluster-fcj`
   - **Infrastructure**: Select **AWS Fargate (serverless)** only

![image](/images/3.3/2025-08-12_19-42-22.png)

4\. Configure monitoring:
   - Scroll down to **Monitoring**
   - Select **Use Container Insights**

![image](/images/3.3/2025-08-12_19-42-22.png)

5\. Review your configuration and click **Create**.

![image](/images/3.3/2025-08-12_19-45-05.png)

6\. **Verify creation**: Confirm that the **fcj-ecs-cluster** appears in your clusters list with "Active" status.

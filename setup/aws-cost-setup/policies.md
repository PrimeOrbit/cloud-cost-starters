### To access the S3 Bucket that contains the CUR Report
```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": [
				"s3:Get*",
				"s3:List*",
				"s3:Describe*"
			],
			"Resource": [
				"arn:aws:s3:::curexports",
				"arn:aws:s3:::curexports/*"
			],
			"Effect": "Allow"
		}
	]
}
```

### Read permissions for the other services
#### No permissions are requested for reading the contents of your application or data. These are just to query the metadata of the services.

```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": [
				"organizations:Describe*",
				"organizations:List*",
				"ec2:Describe*",
				"ec2:Get*",
				"ec2:List*",
				"ec2:Search*",
				"autoscaling:Describe*",
				"autoscaling:Get*",
				"autoscaling-plans:Describe*",
				"autoscaling-plans:Get*",
				"compute-optimizer:Describe*",
				"compute-optimizer:Get*",
				"compute-optimizer:Export*",
				"compute-optimizer:Update*",
				"cur:DescribeReportDefinitions",
				"ce:Describe*",
				"ce:Get*",
				"ce:List*",
				"savingsplans:Describe*",
				"savingsplans:List*",
				"dynamodb:Describe*",
				"dynamodb:Get*",
				"dynamodb:List*",
				"dax:Describe*",
				"dax:Get*",
				"dax:List*",
				"glacier:Describe*",
				"glacier:Get*",
				"glacier:List*",
				"rds:Describe*",
				"rds:List*",
				"cassandra:Select",
				"s3:ListAllMyBuckets",
				"s3:GetBucket*",
				"s3:ListStorageLensConfigurations",
				"s3:GetEncryptionConfiguration",
				"s3:GetIntelligentTieringConfiguration",
				"s3:GetInventoryConfiguration",
				"s3:GetJobTagging",
				"s3:GetLifecycleConfiguration",
				"s3:GetMetricsConfiguration",
				"s3-outposts:Get*",
				"s3-outposts:List*",
				"s3-object-lambda:Get*",
				"s3-object-lambda:List*",
				"lambda:Get*",
				"lambda:List*",
				"aoss:Get*",
				"aoss:List*",
				"es:Describe*",
				"es:Get*",
				"es:List*",
				"elasticache:Describe*",
				"elasticache:List*",
				"elasticloadbalancing:Describe*",
				"ecs:Describe*",
				"ecs:Get*",
				"ecs:List*",
				"states:ListExecutions",
				"states:DescribeExecution",
				"states:DescribeMapRun",
				"states:GetExecutionHistory",
				"trustedadvisor:Get*",
				"trustedadvisor:List*",
				"support:Describe*",
				"support:RefreshTrustedAdvisorCheck",
				"resource-explorer-2:Get*",
				"resource-explorer-2:List*",
				"resource-explorer-2:Search",
				"resource-explorer-2:BatchGetView",
				"ram:List*",
				"ram:Get*",
				"cloudwatch:Describe*",
				"cloudwatch:Get*",
				"cloudwatch:List*",
				"elasticfilesystem:Describe*",
				"elasticfilesystem:List*",
				"ebs:Get*",
				"ebs:List*",
				"cloudtrail:Describe*",
				"cloudtrail:Get*",
				"cloudtrail:List*",
				"cloudtrail:Lookup*",
				"cloudtrail:StartQuery",
				"cloudtrail:CancelQuery",
				"route53:Get*",
				"route53:List*",
				"airflow:Get*",
				"airflow:List*",
				"redshift:Describe*",
				"redshift:Get*",
				"redshift:List*",
				"redshift-serverless:Get*",
				"redshift-serverless:List*",
				"application-autoscaling:DescribeScalableTargets",
				"application-autoscaling:DescribeScalingActivities",
				"application-autoscaling:DescribeScalingPolicies",
				"application-autoscaling:DescribeScheduledActions",
				"eks:Describe*",
				"eks:List*",
				"lightsail:Get*",
				"kafka:Describe*",
				"kafka:Get*",
				"kafka:List*",
				"quicksight:Describe*",
				"quicksight:Get*",
				"quicksight:List*",
				"workspaces:Describe*",
				"workspaces:List*",
				"ecr:Describe*",
				"ecr:List*",
				"ecr:Get*",
				"ecr:Batch*",
				"cloudfront:Get*",
				"cloudfront:List*",
				"sns:Get*",
				"sns:List*",
				"sagemaker:Describe*",
				"sagemaker:List*",
				"acm:Get*",
				"acm:List*",
				"acm:Describe*",
				"kinesis:Get*",
				"kinesis:List*",
				"kinesis:Describe*",
				"elasticmapreduce:List*",
				"elasticmapreduce:Describe*",
				"sdb:Select",
				"waf:Get*",
				"waf:List*",
				"apigateway:Get*",
				"kms:Get*",
				"kms:List*",
				"sqs:ListQueues",
				"servicecatalog:List*"
			],
			"Resource": [
				"*"
			],
			"Effect": "Allow"
		},
		{
			"Action": [
				"dynamodb:GetItem*",
				"dynamodb:GetRecords",
				"dynamodb:GetShardIterator",
				"dax:GetItem*",
				"ec2:GetConsoleOutput",
				"ec2:GetPasswordData",
				"ec2:GetConsoleScreenshot",
				"ec2:GetInstanceUefiData",
				"states:ListExecutions",
				"states:DescribeExecution",
				"states:DescribeMapRun",
				"states:GetExecutionHistory",
				"redshift:ListSavedQueries",
				"redshift:DescribeHsmClientCertificates",
				"redshift:DescribeHsmClientCertificates",
				"redshift:DescribeSavedQueries",
				"redshift:DescribeQuery",
				"ec2:GetConsoleOutput",
				"ec2:GetPasswordData",
				"ec2:GetConsoleScreenshot",
				"ec2:GetInstanceUefiData"
			],
			"Resource": [
				"*"
			],
			"Effect": "Deny"
		}
	]
}
```

### List of Policies
-------------
#### Policy: primeOrbit-organization-access
#### Service: organizations
* Describe*
* List*

-------------
#### Policy: primeorbit-list-permissions-access
#### Service: iam
* ListRolePolicies
* ListPolicies
* GetPolicy



-------------
#### Policy: primeorbit-detect-ec2-opportunities
#### Service: ec2
* Describe*
* Get*
* List*
* Search*
* autoscaling:Describe*
* autoscaling:Get*
* autoscaling-plans:Describe*
* autoscaling-plans:Get*

-------------
#### Policy: primeorbit-detect-computeoptimizer-opportunities
#### Service: compute-optimizer
* Describe*
* Get*
* List*
* Export*
* Update*



-------------
#### Policy: primeorbit-detect-costexplorer-opportunities (again)
#### Service: ce

* Describe*
* Get*
* List*



-------------
#### Policy: primeorbit-detect-rds-opportunities
#### Service: rds

* Describe*
* List*



-------------
#### Policy: primeorbit-detect-s3-opportunities
#### Service: s3

* Describe*
* Get*
* List*
* s3-outposts
* s3-object-lambda

-------------
#### Policy: primeorbit-detect-dynamodb-opportunities
#### Service: dynamodb

* Describe*
* Get*
* List*
#### Service: dax

* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-lambda-opportunities
#### Service: lambda

* Get*
* List*

-------------
#### Policy: primeorbit-detect-stepfunction-opportunities
#### Service: states

* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-ecs-opportunities
#### Service: ecs

* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-elb-opportunities
#### Service: elasticloadbalancing

* Describe*
-------------
#### Policy: primeorbit-detect-ec-opportunities
#### Service: elasticache

* Describe*
* List*
-------------
#### Policy: primeorbit-detect-opensearch-opportunities
#### Service: aoss

* Describe*
* Get*
* List*
#### Service: es

* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-trustedadvisor-opportunities
#### Service: support

* Get*
* List*
* support:Describe*
* support:RefreshTrustedAdvisorCheck

-------------
#### Policy: primeorbit-detect-resources-opportunities
#### Service: resource-explorer-2

* Get*
* List*
* Search
* BatchGetView
* ram:List*
* ram:Get*

-------------
#### Policy: primeorbit-detect-cloudwatch-opportunities
#### Service: cloudwatch

* Describe*
* Get*
* List*

-------------
#### Policy: primeorbit-detect-efs-opportunities
#### Service: elasticfilesystem

* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-cloudtrail-opportunities
#### Service: cloudtrail

* Describe*
* Get*
* List*
* Lookup*
* StartQuery
* CancelQuery
-------------
#### Policy: primeorbit-detect-route53-opportunities
#### Service: route53

* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-mwaa-opportunities
##### Service: airflow
#
* Describe*
* Get*
* List*
-------------
#### Policy: primeorbit-detect-redshift-opportunities
###### Service: redshift
#
* Describe*
* Get*
* List*
* redshift-serverless

-------------
#### Other services are Elastic*, LighSail, ACM, etc.,
* Describe*
* Get*
* List*

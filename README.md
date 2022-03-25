
## Requirements
- [X] IaC -> Create Roles 
- [X] IaC -> Create VPC, Subnets, RTB, IGW and NAT
- [X] IaC -> Create ECS Fargate Cluster
- [X] IaC -> Create Private ECR
- [X] IaC -> Create Fargate Task Definition
- [X] IaC -> Create Application Load Balancer and Target Group
- [X] Script to update ecr image
- [ ] IaC -> Create Cluster Service pointing to task definition
- [ ] IaC -> Attach Service To Load Balancer Target Group
- [ ] IaC CI/CD -> deploy templates in a s3 bucket and update the infrastructure
## Concepts
- Cloudformation
- Nested stack
- Docker
- CI/CD
- Network Diagram

<img src="https://user-images.githubusercontent.com/63565773/160002644-b40f0fd0-1db5-427c-8c0e-83ba71a4c883.png" width="700px"/>

## How to run 


infra
```
cd scripts
chmod +x ./*.sh 
./update-infra.sh

aws cloudformation create-stack --stack-name api-boilerplate-main --capabilities CAPABILITY_IAM --template-body file://./templates/0.main.yml

aws cloudformation create-stack --stack-name api-boilerplate-roles --capabilities CAPABILITY_IAM --template-body file://./templates/0.roles.yml

aws cloudformation create-stack --stack-name api-boilerplate-network --capabilities CAPABILITY_IAM --template-body file://./templates/1.network.yml

aws cloudformation create-stack --stack-name api-boilerplate-ecs-and-ecr --template-body file://./templates/2.ecs-and-ecr.yml

aws cloudformation create-stack --stack-name api-boilerplate-alb --capabilities CAPABILITY_IAM --template-body file://./templates/3.application-load-balancer.yml
```

update image
```
cd scripts 
chmod +x ./*.sh 
./deploy-image.sh
```


delete infra
```
aws cloudformation delete-stack --stack-name api-boilerplate-roles

aws cloudformation delete-stack --stack-name api-boilerplate-network

aws cloudformation delete-stack --stack-name api-boilerplate-alb 

aws cloudformation delete-stack --stack-name api-boilerplate-ecs-and-ecr
```


s3 policy 
```
{
	"Version": "2012-10-17",
	"Id": "Policy1648217333552",
	"Statement": [
		{
			"Sid": "Stmt1648217328932",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:GetObject",
			"Resource": [
				"arn:aws:s3:::api-boilerplate-cloudformation-templates",
				"arn:aws:s3:::api-boilerplate-cloudformation-templates/*"
			]
		}
	]
}
```

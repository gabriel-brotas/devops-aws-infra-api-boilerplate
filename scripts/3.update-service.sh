
aws ecs register-task-definition --family api-boilerplate-main-StackCreateEcsAndAlb-2OSC8ZN3OEN0-APITaskDefinition-bOp2Ax9YIHEk \
--requires-compatibilities "FARGATE" \
--cpu 256 --memory 512 \
--task-role-arn "arn:aws:iam::778568866635:role/api-boilerplate-main-StackCre-ECSTaskExecutionRole-4BKX495GZOMY" \
--execution-role-arn "arn:aws:iam::778568866635:role/api-boilerplate-main-StackCre-ECSTaskExecutionRole-4BKX495GZOMY" \
--network-mode "awsvpc" \
--container-definitions '[{"name":"my-api","image":"778568866635.dkr.ecr.us-east-1.amazonaws.com/api-boilerplate-ecr-repository:1.0.0","essential":true,"portMappings":[{"containerPort":4000,"hostPort":4000,"protocol":"tcp"}]}]'

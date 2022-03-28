# TODO: get values by flags
# TODO: update image dynamically

export REPOSITORY_ID="778568866635.dkr.ecr.us-east-1.amazonaws.com"
export REPOSITORY_NAME="api-boilerplate-ecr-repository"
export IMAGE_TAG="1.2.0"

cd .. 

# aws ecr describe-images --repository-name api-boilerplate-ecr-repository
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPOSITORY_ID

docker build -t $REPOSITORY_NAME:$IMAGE_TAG .

docker tag $REPOSITORY_NAME:$IMAGE_TAG $REPOSITORY_ID/$REPOSITORY_NAME:$IMAGE_TAG

docker push $REPOSITORY_ID/$REPOSITORY_NAME:$IMAGE_TAG

aws ecs register-task-definition --family api-boilerplate-main-StackCreateEcsAndAlb-1SO10Z3MY92B7-APITaskDefinition-tKGfTJdMSZ3e \
--requires-compatibilities "FARGATE" \
--cpu 256 --memory 512 \
--task-role-arn "arn:aws:iam::778568866635:role/api-boilerplate-main-StackCre-ECSTaskExecutionRole-1PEHDV5R7TPYF" \
--execution-role-arn "arn:aws:iam::778568866635:role/api-boilerplate-main-StackCre-ECSTaskExecutionRole-1PEHDV5R7TPYF" \
--network-mode "awsvpc" \
--container-definitions '[{"name":"my-api","image":"778568866635.dkr.ecr.us-east-1.amazonaws.com/api-boilerplate-ecr-repository:1.2.0","essential":true,"portMappings":[{"containerPort":4000,"hostPort":4000,"protocol":"tcp"}]}]'

aws ecs update-service --cluster api-boilerplate-cluster-fargate \
--service my-service \
--task-definition api-boilerplate-main-StackCreateEcsAndAlb-1SO10Z3MY92B7-APITaskDefinition-tKGfTJdMSZ3e \
--desired-count 2

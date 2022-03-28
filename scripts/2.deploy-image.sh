# TODO: get values by flags
# TODO: update image dynamically

export REPOSITORY_ID="778568866635.dkr.ecr.us-east-1.amazonaws.com"
export REPOSITORY_NAME="api-boilerplate-ecr-repository"
export IMAGE_TAG="1.0.0"

cd .. 

# aws ecr describe-images --repository-name api-boilerplate-ecr-repository

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPOSITORY_ID

docker build -t $REPOSITORY_NAME:$IMAGE_TAG .

docker tag $REPOSITORY_NAME:$IMAGE_TAG $REPOSITORY_ID/$REPOSITORY_NAME:$IMAGE_TAG

docker push $REPOSITORY_ID/$REPOSITORY_NAME:$IMAGE_TAG
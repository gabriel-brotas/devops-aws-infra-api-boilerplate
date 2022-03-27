aws s3 rm s3://api-boilerplate-cloudformation-templates --recursive

aws s3 cp ../templates/ s3://api-boilerplate-cloudformation-templates --recursive 

# aws cloudformation create-stack --stack-name api-boilerplate-main --capabilities CAPABILITY_IAM --template-body file://../templates/0.main.yml
aws cloudformation update-stack --stack-name api-boilerplate-main --capabilities CAPABILITY_IAM --template-body file://../templates/0.main.yml

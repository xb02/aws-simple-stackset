#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/33-create-codepipeline-stack.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to create stack for codepipeline
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://aws.amazon.com/blogs/devops/passing-parameters-to-cloudformation-stacks-with-the-aws-cli-and-powershell/

StackName="xb-pipeline-test-01"

StackStatus=$(aws --profile innovation cloudformation describe-stacks --stack-name ${StackName} 2>/dev/null | jq '.Stacks[].StackStatus')
echo ${StackStatus}

if [ -z $StackStatus ]
then
  AwsCliCmd='create'
else
  AwsCliCmd='update'
fi


aws --profile innovation cloudformation ${AwsCliCmd}-stack                      \
    --stack-name ${StackName}  --capabilities CAPABILITY_NAMED_IAM              \
    --tags file://../45-aws-cli-params/stackset-stack-generic-tags.json         \
    --template-body file://../55-codepipeline/simple-ec2-codepipeline.yml       \
    --parameters file://../45-aws-cli-params/codepipeline-xb02-master-params.json


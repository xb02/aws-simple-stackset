#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/35-update-codepipeline-stack.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to update codepipeline stack
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/update-stack.html

StackName="xb-pipeline-test-01"

aws --profile innovation cloudformation update-stack --stack-name ${StackName}    \
    --capabilities CAPABILITY_NAMED_IAM                                           \
    --template-body file://../55-codepipeline/simple-ec2-codepipeline.yml         \
    --tags file://../45-aws-cli-params/stackset-stack-generic-tags.json           \
    --parameters file://../45-aws-cli-params/codepipeline-xb02-master-params.json

#    --parameters file://../45-aws-cli-params/codepipeline-xb02-update-params.json


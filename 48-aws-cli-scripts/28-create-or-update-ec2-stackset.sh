#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/28-create-or-update-ec2-stackset.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : simple shell script to create (if there is none) or 
#               update (if it exists)  create stackset for simple EC2 instance
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack-set.html
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/update-stack-set.html


stack_status=$(aws  --profile innovation cloudformation describe-stack-set  --stack-set-name create-simple-single-ec2-stackset 2>/dev/null | jq '.StackSet.Status')
echo ${stack_status}

if [ -z $stack_status ]
then
  aws_cli_cmd=create
else
  aws_cli_cmd=update
fi
echo ${aws_cli_cmd}

aws --profile innovation cloudformation "${aws_cli_cmd}-stack-set"    \
    --stack-set-name create-simple-single-ec2-stackset                \
    --description "single ec2 instance creation stackset"             \
    --template-body file://../42-simple-ec2/simple-single-ec2-cft.yml \
    --tags file://../45-aws-cli-params/simple-ec2-instance-tags.json  \
    --parameters file://../45-aws-cli-params/simple-ec2-stackset-default-params.json

#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/25-update-simple-ec2-stackset.sh
# Date        : 10 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to create stackset for simple EC2 instance
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/update-stack-set.html

StackSetName="create-simple-single-ec2-stackset"
aws --profile innovation cloudformation update-stack-set              \
    --stack-set-name ${StackSetName}                                  \
    --description "single ec2 instance creation stackset"             \
    --template-body file://../42-simple-ec2/simple-single-ec2-cft.yml \
    --tags file://../45-aws-cli-params/simple-ec2-instance-tags.json  \
    --parameters file://../45-aws-cli-params/simple-ec2-stackset-default-params.json

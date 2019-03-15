#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/29-update-simple-ec2-stackinstance.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to update the stack created through stackset for simple EC2 instance
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/update-stack-instances.html

# add this additional option to generate a skeleton
#    --generate-cli-skeleton

StackSetName="create-simple-single-ec2-stackset"
aws --profile innovation                                \
    cloudformation update-stack-instances               \
    --stack-set-name ${StackSetName}                    \
    --regions  "us-west-2"                              \
    --accounts "579357099184"                           \
    --parameter-overrides "ParameterKey=pMyIp,ParameterValue=172.9.238.213/32,ParameterKey=pPubSubnetAZ,ParameterValue=/Vpc/Dev/Pub/Subnet/AZa"

#    --parameter-overrides file://../45-aws-cli-params/simple-ec2-params.json



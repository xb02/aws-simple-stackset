#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/45-delete-simple-ec2-stackinstance.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to delete stack instance created through stackset for simple EC2 instance
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/delete-stack-instances.html

# add this additional option to generate a skeleton
#    --generate-cli-skeleton

aws --profile innovation                                \
    cloudformation delete-stack-instances               \
    --stack-set-name create-simple-single-ec2-stackset  \
    --no-retain-stacks                                  \
    --regions  "us-west-2"                              \
    --accounts "579357099184"                           \


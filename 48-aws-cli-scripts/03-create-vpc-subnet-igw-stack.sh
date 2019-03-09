#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/03-create-vpc-subnet-igw-stack.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to create stack for creating vpc subnet and internet gateway
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://aws.amazon.com/blogs/devops/passing-parameters-to-cloudformation-stacks-with-the-aws-cli-and-powershell/


aws --profile innovation cloudformation create-stack --stack-name create-vpc-subnet-igw \
    --template-body file://../20-network-setup/vpc-subnet-igw-paramstore.yml            \
    --parameters file://../45-aws-cli-params/dev-bu1-vpc-subnet-igw-params.json

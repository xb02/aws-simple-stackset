#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/12-create-vpc-subnet-igw-stackset.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to create stackset for creating vpc subnet and internet gateway
#


# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack-set.html


aws --profile innovation cloudformation create-stack-set                        \
    --stack-set-name vpc-subnet-igw-stackset                                    \
    --description "vpc subnet igw using stackset"                               \
    --template-body file://../20-network-setup/vpc-subnet-igw-paramstore.yml    \
    --tags file://../45-aws-cli-params/dev-bu1-vpc-subnet-igw-tags.json         \
    --parameters file://../45-aws-cli-params/dev-bu1-vpc-subnet-igw-params.json

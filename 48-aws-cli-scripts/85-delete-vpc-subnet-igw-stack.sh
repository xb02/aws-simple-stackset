#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/85-delete-vpc-subnet-igw-stack.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to delete stack
#

aws --profile innovation cloudformation delete-stack --stack-name create-vpc-subnet-igw 

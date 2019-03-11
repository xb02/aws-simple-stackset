#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/49-delete-simple-ec2-stackset.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to delete stackset 
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# :g/\([a-zA-Z0-9]\+\)\([ ]\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/delete-stack-set.html

aws --profile innovation cloudformation delete-stack-set --stack-set-name create-simple-single-ec2-stackset


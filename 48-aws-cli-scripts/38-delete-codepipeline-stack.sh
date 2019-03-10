#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/38-delete-codepipeline-stack.sh
# Date        : 08 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to delete codepipeline stack
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/delete-stack.html

aws --profile innovation cloudformation delete-stack --stack-name "xb-pipeline-test01"


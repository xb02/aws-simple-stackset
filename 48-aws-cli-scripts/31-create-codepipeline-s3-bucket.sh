#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/31-create-codepipeline-s3-bucket.sh
# Date        : 10 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to create S3 bucket for codepipeline
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://aws.amazon.com/blogs/devops/passing-parameters-to-cloudformation-stacks-with-the-aws-cli-and-powershell/


aws --profile innovation cloudformation create-stack --stack-name "xb-s3-bucket-pipeline" \
    --tags file://../45-aws-cli-params/stackset-stack-generic-tags.json                   \
    --template-body file://../55-codepipeline/s3-bucket-for-codepipeline.yml              \
    --parameters file://../45-aws-cli-params/codepipeline-s3-bucket-params.json


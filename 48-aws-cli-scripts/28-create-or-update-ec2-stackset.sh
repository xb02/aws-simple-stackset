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


StackSetName="create-simple-single-ec2-stackset"
StackStatus=$(aws  --profile innovation cloudformation describe-stack-set  --stack-set-name ${StackSetName} 2>/dev/null | jq '.StackSet.Status')
echo ${StackStatus}

if [ -z $StackStatus ]
then
  AwsCliCmd=create
else
  AwsCliCmd=update
  OperPrefsWithFile="--operation-preferences file://../45-aws-cli-params/simple-ec2-stackset-oper-pref.json"
fi
echo ${AwsCliCmd}

OperId=$(aws --profile innovation cloudformation "${AwsCliCmd}-stack-set"     \
             --stack-set-name ${StackSetName}                                 \
             --description "single ec2 instance creation stackset"            \
             --capabilities CAPABILITY_NAMED_IAM                              \
             --tags file://../45-aws-cli-params/simple-ec2-instance-tags.json \
             --template-body file://../42-simple-ec2/simple-single-ec2-cft.yml                      \
             --parameters file://../45-aws-cli-params/simple-ec2-stackset-default-params.json       \
             ${OperPrefsWithFile} 2>/dev/null | jq '.OperationId' | sed -e 's,\",,g')

echo "Operation id: ${OperId}"
while true
do
  sleep 5
  if [ -z $OperId ]; then break; fi

  AwsCfnDesStkSetOpr="aws cloudformation describe-stack-set-operation --stack-set-name ${StackSetName}"
  OperStatus=$(${AwsCfnDesStkSetOpr} --operation-id ${OperId} 2>/dev/null | jq '.StackSetOperation.Status')
  if [ -z $OperStatus ]; then break; fi

  if [ ${OperStatus} != '"RUNNING"' ]; then break; fi
done

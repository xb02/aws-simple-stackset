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

StackSetName="create-simple-single-ec2-stackset"

for ix in $(cat ../45-aws-cli-params/simple-ec2-stack-accounts.txt)
do

  IFS=',' read -r -a AccRegArray <<< "${ix}"
  AccNum=${AccRegArray[0]}
  RegName=${AccRegArray[1]}
  echo "Account number: ${AccNum}"
  echo "Account region: ${RegName}"

  OperId=$(aws --profile innovation cloudformation delete-stack-instances   \
               --stack-set-name ${StackSetName} --no-retain-stacks          \
               --regions ${RegName} --accounts ${AccNum} 2>/dev/null |      \
               jq '.OperationId' | sed -e 's,\",,g')

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

done

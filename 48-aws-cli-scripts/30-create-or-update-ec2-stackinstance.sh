#! /bin/bash

# 
# Filename    : aws-simple-stackset/48-aws-cli-scripts/30-create-or-update-ec2-stackinstance.sh
# Date        : 10 Mar 2019
# Author      : Balaji Venkataraman (xbalaji@gmail.com)
# Description : AWS CLI command to create stack instance from simple EC2 instance stackset
#

# copy the parameters from an existing stack out, use the following command to convert to json in vim
# g/\(\S\+\)\(\s\+\)\(\S\+\)\(.*\)/s//  {\r    "ParameterKey": "\1",\r    "ParameterValue": "\3"\r  },/gc

# aws cli reference example
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack-instances.html
# https://docs.aws.amazon.com/cli/latest/reference/cloudformation/update-stack-instances.html


StackSetName="create-simple-single-ec2-stackset"
for ix in $(cat ../45-aws-cli-params/simple-ec2-stack-accounts.txt)
do

  IFS=',' read -r -a AccRegArray <<< "${ix}"
  AccNum=${AccRegArray[0]}
  RegName=${AccRegArray[1]}
  echo "Account number: ${AccNum}"
  echo "Account region: ${RegName}"

  CmdLine="aws --profile innovation cloudformation describe-stack-instance --stack-set-name ${StackSetName}"
  InstanceStatus=$(${CmdLine} --stack-instance-account ${AccNum} --stack-instance-region ${RegName} 2>/dev/null | jq '.StackInstance.Status')
  echo "instance status: ${InstanceStatus}"

  if [ -z $InstanceStatus ]
  then
    AwsCliCmd=create
  else
    AwsCliCmd=update
  fi
    
  OperId=$(aws --profile innovation cloudformation "${AwsCliCmd}-stack-instances"       \
      --stack-set-name ${StackSetName} --accounts "${AccNum}" --regions  "${RegName}"   \
      --parameter-overrides file://../45-aws-cli-params/simple-ec2-params.json 2> /dev/null | jq '.OperationId')

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

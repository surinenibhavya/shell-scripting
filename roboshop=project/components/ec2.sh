#!/bin/bash

INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
 echo "Instance name argumnet is neeeded"
 exit
fi

AMI_ID=$( aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)
if [ -z "${AMI_ID}" ]; then
 echo "unable to find image AMIID"
 exit
else
 echo AMI ID =${AMI_ID}
fi

aws ec2 run-instances --image-id  ${AMI_ID} --instance-type t2.micro --output text --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,{INSTANCE_NAME}}]'
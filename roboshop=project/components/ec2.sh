#!/bin/bash
INSTANCE_NAME=$1
if[ -z "$INSTANCE_NAME"]; then
 echo "argument needed"
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)
if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31mUnable to find image AMI ID\e[0m"
  exit 1
else
  echo -e "\e[1;32mAMI ID = ${AMI_ID}\e[0m"
fi

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text
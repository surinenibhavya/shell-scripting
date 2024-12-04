#!/bin/bash
echo $1
INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
  echo -e "\e[1;33mInstance name argument is needed\e[0m"
  exit 1
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)
if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31mUnable to find image AMI ID\e[0m"
  exit 1
else
  echo -e "\e[1;32mAMI ID = ${AMI_ID}\e[0m"
fi

# Debug output
echo -e "\e[1;34mRunning EC2 instance with the following details:\e[0m"
echo -e "\e[1;34mINSTANCE_NAME: ${INSTANCE_NAME}\e[0m"
echo -e "\e[1;34mAMI_ID: ${AMI_ID}\e[0m"

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro --output text --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${INSTANCE_NAME}}]"

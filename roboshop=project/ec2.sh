#!/bin/bash

INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
 echo "Input argument needed"
 exit
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)
if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31mUnable to find image AMI ID\e[0m"
  exit
else
  echo -e "\e[1;32mAMI ID = ${AMI_ID}\e[0m"
fi

PRIVATE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name ,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

if [ -z "${PRIVATE_IP}" ]; then
 SG_ID=$(aws ec2 describe-security-groups --filter Name=group-name,Values=allow-all-ports --query "SecurityGroups[*].GroupId" --output text)
 if [ -z "${SG_ID}" ]; then
   echo "Security group does not exist"
   exit
 fi
 aws ec2 run-instances --image-id "${AMI_ID}" --instance-type t3.micro --output text --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${INSTANCE_NAME}}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${INSTANCE_NAME}}]" --instance-market-options "MarketType=spot,SpotOptions={InstanceInterruptionBehavior=stop,SpotInstanceType=persistent}" --security-group-ids"${SG_id}"
else
 echo "Already ${INSTANCE_NAME} is there"
fi



#!/bin/bash
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)
if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31mUnable to find image AMI ID\e[0m"
  exit 1
else
  echo -e "\e[1;32mAMI ID = ${AMI_ID}\e[0m"
fi

aws ec2 run-instances \
    --image-id ami-0abcdef1234567890 \
    --instance-type t2.micro \
    --count 1 \
    --subnet-id subnet-08fc749671b2d077c \
    --key-name MyKeyPair \
    --security-group-ids sg-0b0384b66d7d692f9 \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=server,Value=production}]' 'ResourceType=volume,Tags=[{Key=cost-center,Value=cc123}]'
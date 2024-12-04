#!/bin/bash

AMI_ID=$( aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]'
)
if [ -z "${AMI_ID}" ]; then
 echo "unable to find image AMIID"
else
 echo AMI ID =${AMI_ID}
fi

aws ec2 run-instances --image-id${AMI_ID} --instance-type t3.micro
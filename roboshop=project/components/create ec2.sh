#!/bin/bash

AMI_ID=$( aws ec2 describe-images --filters "Name=name,Values=Centos-8-DevOps-Practice" --query 'Images[*].[ImageId]'
)
if [-z "$(AMI_ID)"]; then
 echo "unable to finf image AMIID"
 exit
 
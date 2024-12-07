#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]; then
 echo "you should be root user to execute the script"
 exit
fi

if [ -f components/$1.sh ]; then
  bash components/$1.sh
else
  echo -e "\e[1;31mInvalid inputs\e[0m"
  echo -e "\e[1;33mAvailable inputs-frontend|mongodb|catalogue|redis|user|cart|mysql|shipping|rabbitmq|payment|dispatch\e[0m"
fi


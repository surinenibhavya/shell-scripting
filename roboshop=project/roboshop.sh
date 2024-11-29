#!/bin/bash

if [-f bash components/$1.sh]; then
  bash components/$1.sh
else
  echo -e "\e[1;31mInvalid inputs\e[0m"
  echo -e "\e[1;33mAvailable inputs-fronend|mongodb|catalogue|redis|user|cart|mysql|shipping|rabbitmq|payment|dispatch\e[0m"
fi

#!/bin/bash

SAMPLE()
{
echo "a"
return
echo "b"
}

SAMPLE
SAMPLE

S()
{
echo "print $1"
}
echo "fff $1"
S
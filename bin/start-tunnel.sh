#!/bin/bash
hostname=$(hostname)
# Check if the hostname starts with 'llama'
if [[ $hostname == llama* ]]; then
  echo "Remember to run this on your CLIENT!"
  exit 1
fi
ssh -L 8081:localhost:8081 -p 30146 alba@147.83.113.192

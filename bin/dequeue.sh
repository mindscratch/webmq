#!/usr/bin/env sh
#
# Dequeue an item
#
# example: dequeue.sh test 

if [ $# -eq 0 ] || [ $1 == "--help" ] || [ $1 == '-h' ]; then
  echo "Usage: $0 <queue name>" 
  exit 1
fi 

host="http://localhost:3000/"
queue_name=$1
curl -i -H "Accept: application/json" "$host/q/$queue_name/dequeue"
echo

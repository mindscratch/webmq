#!/usr/bin/env sh
#
# Enqueue some data
#
# example: enqueue.sh test '{"foo": 1, "bar": 2}'
if [ $# -eq 0 ] || [ $1 == "--help" ] || [ $1 == '-h' ]; then
  echo "Usage: $0 <queue name> <json data>"
  exit 1
fi 

payload='{"payload": '$2'}'

host="http://localhost:3000/"
queue_name=$1
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d "$payload" "$host/q/$queue_name"
echo

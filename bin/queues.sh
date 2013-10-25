#!/usr/bin/env sh
#
# Get the list of queues

host="http://localhost:3000/"
curl -i -H "Accept: application/json" "$host/queues"
echo

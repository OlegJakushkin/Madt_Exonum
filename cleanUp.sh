#!/usr/bin/env bash
node_count=4
for i in $(seq 0 $((node_count-1)))
do
  sudo docker stop MADT_exonum_Node${i}
  sleep 1
  sudo docker rm MADT_exonum_Node${i}
done
#!/usr/bin/env bash

node_count=$1
for i in $(seq 0 $((node_count - 1)))
do
  sudo docker exec -it MADT_exonum_Node${i} ./docker/run.sh ${i}
done
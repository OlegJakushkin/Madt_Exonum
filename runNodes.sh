#!/usr/bin/env bash

node_count=4
for i in $(seq 0 $((node_count - 1)))
do
  docker exec -d MADT_exonum_Node${i} ./docker/run.sh ${i}
  sleep 1
done

docker exec -d MADT_exonum_Node0 ./docker/runWeb.sh
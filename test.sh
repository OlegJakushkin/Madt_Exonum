#!/bin/bash

for i in $(seq 0 4)
do
    curl http://127.0.0.1:800${i}/api/v1/wallets/info
done

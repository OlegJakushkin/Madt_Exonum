#!/usr/bin/env bash
node_count=4
start_public_port=8000
cd ../frontend
npm start -- --port=$((start_public_port + 2 * node_count)) --api-root=http://172.18.0.2:${start_public_port}
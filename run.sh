#!/usr/bin/env bash
node=$1
node_count=4
start_peer_port=6331
start_public_port=8000
path_to_app=/root/.cargo/bin/exonum-cryptocurrency-advanced
public_port=$((start_public_port + node))
private_port=$((public_port + node_count))
chmod 600 ./docker/example/$((node + 1))/master.key.toml
${path_to_app} run --node-config ./docker/example/$((node + 1))/node.toml --db-path ./docker/example/$((node + 1))/db --public-api-address 15.0.0.$((node + 2)):${public_port} --master-key-pass pass &
echo "new node with ports: $public_port (public) and $private_port (private)"
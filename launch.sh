
#!/usr/bin/env bash

node=$1
node_count=5
start_peer_port=6331
start_public_port=8000
path_to_app=/root/.cargo/bin/exonum-cryptocurrency-advanced

cd backend && mkdir example && cd example
${path_to_app} generate-template common.toml --validators-count ${node_count}

peer_port=$((start_peer_port + node))
${path_to_app} generate-config common.toml ${node} --peer-address 127.0.0.1:${peer_port} -n

public_port=$((start_public_port + node))
private_port=$((public_port + 100))
${path_to_app} finalize --public-api-address 0.0.0.0:${public_port} --private-api-address 0.0.0.0:${private_port} ${node}/sec.toml ${node}/node.toml --public-configs {1,2,3,4,5}/pub.toml

public_port=$((start_public_port + node))
private_port=$((public_port + 100))
${path_to_app} run --node-config ${node}/node.toml --db-path ${node}/db --public-api-address 0.0.0.0:${public_port} --master-key-pass pass &
echo "new node with ports: $public_port (public) and $private_port (private)"
sleep 1

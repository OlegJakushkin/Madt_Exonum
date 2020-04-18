#!/bin/bash

set -e

BASE_URL=http://127.0.0.1:8000/api/services/cryptocurrency/v1
TX_URL=http://127.0.0.1:8000/api/explorer/v1/transactions

function transaction {
    RESP=`curl -H "Content-Type: application/json" -X POST -d @$1 $TX_URL 2>/dev/null`
    sleep 1
}

function check-transaction {
	echo "OK, got expected transaction hash $1. Hash: $RESP"
}

function check-request {
	echo "OK, got expected transaction balance $2 for user $1. Hash: $RESP"
}

function check-create-tx {
	echo "OK, got expected TxCreateWallet for user. Hash: $3"
}

function check-transfer-tx {
	echo "OK, got expected TxTransfer between wallets. Hash: $2"
}

echo "Creating a wallet for Alice..."
transaction tx-create-wallet-1.json
check-transaction be8531a8

echo "Creating a wallet for Bob..."
transaction tx-create-wallet-2.json
check-transaction 4d73a036

echo "Add funds to Alice's wallet..."
transaction tx-issue.json
check-transaction 4622eb1e

echo "Transferring funds from Alice to Bob..."
transaction tx-transfer.json
check-transaction 06aa2c6f

echo "Waiting until transactions are committed..."
sleep 5

echo "Retrieving info on Alice's wallet..."
RESP=`curl $BASE_URL/wallets/info?pub_key=cf6e0ddfe440ad799bb78ce2e9b99d60481c2aa0ca7bf968383e1b97981a255d 2>/dev/null`
check-request "Alice" 140 "$RESP"

echo "Retrieving info on Bob's wallet..."
RESP=`curl $BASE_URL/wallets/info?pub_key=e73805c9f0cc566c0ecd61c56d2ac3b25187eec1e2922f23152b5f0c05af8531 2>/dev/null`
check-request "Bob" 110 "$RESP"

echo "Test completed"



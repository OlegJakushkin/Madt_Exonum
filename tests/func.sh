#!/bin/bash

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


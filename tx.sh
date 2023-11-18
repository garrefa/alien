#!/bin/bash

curl --location --request POST 'https://solana-devnet.g.alchemy.com/v2/MtjDu-CqjjwDWYm1OJIQthamdpq02hFT' \
--header 'Content-Type: application/json' \
--data-raw '{
    "id": "0",
    "method": "simulateTransaction",
    "jsonrpc": "2.0",
    "params": [
        "5nmRjKYBrD56XiCeZDns9VqRWCM6QeGuj1asaCAkpa4PtdHSUpfnwsw2pFpMPT4URodm46t2zQ2hN3zqDGDp2CUAcqMduZM9ohpW2hfJgPUZaiyiJgAPUimweSj8eZYwkrtFoTo3vhBDghBhq9VqDDELtqL5jtitKuscQFU5b4CacUsdmfXCtQdurL4wiP76Q5xEBr6Z1EmdrAhsf53YgiDLsAFEg2HXxD4Qehn7KdoUkjbqVtaPNXggpnjhhasF3Yt5EMygSqFbx2tTstFQ2KYnoeLGu15zC2AdV",
        {
            "encoding": "base58",
            "commitment": "recent",
            "sigVerify": false,
            "replaceRecentBlockhash" :true,
            "accounts": {
                "addresses": [
                    "4bq46im9W4VjuXQ9ftuqJkzm8bAbtay1nEvwxg15pZ9V",
                    "HPU6qz4ixcAicQdDTDRY6AoTkv37Pw2te9U4p9h3SYU2",
                    "11111111111111111111111111111111"
                ]
            }
        }
    ]
}'
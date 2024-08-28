forge script ./script/Aggregator.s.sol:AggregatorScript --chain-id 1313161555 --rpc-url https://testnet.aurora.dev/ \
    --verify --verifier blockscout --verifier-url https://explorer.testnet.aurora.dev/api \
    --broadcast --private-key $PRIVATE_KEY --legacy -vvvv
    
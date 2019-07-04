#!/usr/bin/env bash
# First check the accounts to ensure they have funds
nscli query account $(nscli keys show jack -a) \
    --chain-id testchain
nscli query account $(nscli keys show alice -a) \
    --chain-id testchain

# Buy your first name using your coins from the genesis file
nscli tx nameservice buy-name jack.id 15mycoin \
    --from     jack \
    --chain-id testchain <<EOF
asdfghjkl
EOF

# Set the value for the name you just bought
nscli tx nameservice set-name jack.id 8.8.8.8 \
    --from     jack \
    --chain-id testchain <<EOF
asdfghjkl
EOF

# Try out a resolve query against the name you registered
nscli query nameservice resolve jack.id --chain-id testchain
# > 8.8.8.8

# Try out a whois query against the name you just registered
nscli query nameservice whois jack.id --chain-id testchain
# > {"value":"8.8.8.8","owner":"cosmos1l7k5tdt2qam0zecxrx78yuw447ga54dsmtpk2s","price":[{"denom":"mycoin","amount":"5"}]}

# Alice buys name from jack
nscli tx nameservice buy-name jack.id 10mycoin \
    --from     alice \
    --chain-id testchain <<EOF
asdfghjkl
EOF

#!/usr/bin/env bash

./killbyname.sh "nsd start"

rm -rf ~/.nsd
rm -rf ~/.nscli

# Initialize configuration files and genesis file
nsd init --chain-id testchain

# Copy the `Address` output here and save it for later use
nscli keys add jack <<EOF
asdfghjkl
EOF

# Copy the `Address` output here and save it for later use
nscli keys add alice <<EOF
asdfghjkl
EOF

# Add both accounts, with coins to the genesis file
nsd add-genesis-account $(nscli keys show jack -a) 1000mycoin,1000jackcoin
nsd add-genesis-account $(nscli keys show alice -a) 1000mycoin,1000alicecoin

# Configure your CLI to eliminate need for chain-id flag
nscli config chain-id testchain
#nscli config output json
nscli config indent true
nscli config trust-node true

ln -svnf ~/.nsd _nsd
ln -svnf ~/.nscli _nscli

sleep 1
./start.sh
sleep 1
tail -f _nsd/nsd.log
#!/usr/bin/env bash

curdir=`pwd`

if [ ! -d $GOPATH/src/github.com/cmdpos/cmapp ]; then
    echo "$GOPATH/src/github.com/cmdpos/cmapp does not exit"
    exit
fi

(cd .. && ln -svnf $GOPATH/src/github.com/cmdpos/cmapp/vendor vendor)

./killbyname.sh "nsd start"

rm -rf ~/.nsd
rm -rf ~/.nscli

mnemonic1="entry arrow south catalog menu timber plate glass service tobacco extend taxi"
#cmdpos1vvud4ccc030ss6r3ldwxfy2f8f750u3mxajz4y

mnemonic2="script leave strategy close trial nurse prize music shiver quote viable creek"
#cmdpos1475jdmkc57kuaj03mq9d7hrxv7e5tc0asejwgg

# Initialize configuration files and genesis file
nsd init --chain-id testchain

# Copy the `Address` output here and save it for later use
#nscli keys add jack
nscli keys add jack --recover -m "$mnemonic1"

# Copy the `Address` output here and save it for later use
#nscli keys add alice
nscli keys add alice --recover -m "$mnemonic2"


# Add both accounts, with coins to the genesis file
nsd add-genesis-account $(nscli keys show jack -a) 600000000000mycoin,10000000000jackcoin
nsd add-genesis-account $(nscli keys show alice -a) 800000000000mycoin,10000000000000alicecoin

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
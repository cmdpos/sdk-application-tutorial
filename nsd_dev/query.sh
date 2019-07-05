#!/usr/bin/env bash

nscli query account $(nscli keys show jack -a) --chain-id testchain
nscli query account $(nscli keys show alice -a) --chain-id testchain

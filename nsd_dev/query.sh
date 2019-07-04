#!/usr/bin/env bash

nscli query account $(nscli keys show $1 -a) --chain-id testchain

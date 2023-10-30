#!/bin/bash 

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id= 1lUYJXEzJlBW3tLNS2BoR5CsAwZdx8sz8' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id= 1lUYJXEzJlBW3tLNS2BoR5CsAwZdx8sz8" -O archcraft-23.10.12-x86_64.iso && rm -rf /tmp/cookies.txt

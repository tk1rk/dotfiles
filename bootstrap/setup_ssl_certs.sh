#!/usr/bin/env sh

# DESC: Creates certificate (files key,crt,pem), see -h

[[ -z "$1" || "$1" = "-h" || "$1" = "--help" ]] && { print "Usage: pssetup_ssl_cert {name} [output dir path]"; return 0; }
local FILENAME="$1"

command mkdir -p "${2:-$HOME/safe/socat}"
builtin cd "${2:-$HOME/safe/socat}"

# Generate a public/private key pair
command rm -f $FILENAME.key
builtin print -- "${fg[green]}Generating public/private key pair (output: $FILENAME.key)$reset_color"
command openssl genrsa -out $FILENAME.key 1024

# Generate a self-signed certificate
command rm -f $FILENAME.crt
builtin print -- "${fg[green]}Generating self-signed certificate (output: $FILENAME.crt)$reset_color"
command openssl req -new -key $FILENAME.key -x509 -days 3653 -out $FILENAME.crt

# Generate the PEM file by just appending the key and certificate files
command rm -f $FILENAME.pem
builtin print -- "${fg[green]}Create PEM file (output: $FILENAME.pem)$reset_color"
command cat $FILENAME.key $FILENAME.crt >! $FILENAME.pem

builtin print -- "${fg[green]}chmod 600 $FILENAME.key $FILENAME.pem$reset_color"
command chmod 600 $FILENAME.key $FILENAME.pem

builtin print -- "${fg[yellow]}Next step is to copy the certificate (${fg[red]}$FILENAME.crt${fg[yellow]}) to the opposite host"

# vim:ft=zsh:et

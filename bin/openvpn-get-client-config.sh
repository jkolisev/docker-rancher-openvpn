#!/bin/bash

OPENVPNDIR="/etc/openvpn"
. $OPENVPNDIR/remote.env
CA_CONTENT=$(cat $OPENVPNDIR/easy-rsa/keys/ca.crt)

cat <<- EOF
remote $REMOTE_IP $REMOTE_PORT
client
dev tun
proto tcp
remote-random
resolv-retry infinite
cipher AES-256-CBC
auth SHA256
nobind
link-mtu 1500
persist-key
persist-tun
verb 3
auth-user-pass
auth-retry interact
<ca>
$CA_CONTENT
</ca>
EOF

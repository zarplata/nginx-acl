#!/usr/bin/env bash

set -o nounset # Treat unset variables as an error

rule=${1:-}
asn=${2:-}

if [[ -z "$rule" ]] || [[ -z "$asn" ]]; then
    echo "error: invalid arguments"
    echo "usage:"
    echo -e "\tnginx-acl.sh <rule> <asn>"
    echo -e "\tnginx-acl.sh allow 14061"
    echo -e "\tnginx-acl.sh deny 14061"
    exit 1
fi

curl -sS --fail "https://stat.ripe.net/data/as-overview/data.json?resource=AS{$asn}&sourceapp=nginx-acl" \
    | jq -r '"# AS" + .data.resource + ", " + .data.holder + ", " + .time'

curl -H 'Accept: application/json' -sS --fail "https://rest.db.ripe.net/search?source=ripe&type-filter=route,route6&inverse-attribute=origin&query-string=AS${asn}" \
    | jq -r '.objects.object[]."primary-key".attribute[] | select(.name != "origin") | .value' \
    | xargs -I% echo "${rule} %;"

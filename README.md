# nginx-acl
Generator of NGINX ACL rules by autonomous system number (ASN)

## Installation

```
git clone https://github.com/zarplata/nginx-acl.git
```

## Dependent binaries

* jq
* curl
* xargs

## Usage

Allow AS14061 (Digital Ocean).
```
nginx-acl.sh allow 14061 > /etc/nginx/config/allow/digital-ocean.conf
```

Deny AS14061 (Digital Ocean).
```
nginx-acl.sh deny 14061 > /etc/nginx/config/deny/digital-ocean.conf
```

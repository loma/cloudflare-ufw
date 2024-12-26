#!/bin/bash

if [ -e ./ips-v4 ]; then
  for cfip in `cat ips-v4`; do ufw delete allow from $cfip to any port 80; done
  for cfip in `cat ips-v4`; do ufw delete allow from $cfip to any port 443; done
fi

if [ -e ./ips-v4 ]; then
  for cfip in `cat ips-v6`; do ufw delete allow from $cfip to any port 80; done
  for cfip in `cat ips-v6`; do ufw delete allow from $cfip to any port 443; done
fi

curl https://www.cloudflare.com/ips-v4 -Os
curl https://www.cloudflare.com/ips-v6 -Os

for cfip in `cat ips-v4`; do ufw allow from $cfip to any port 80; done
for cfip in `cat ips-v4`; do ufw allow from $cfip to any port 443; done

for cfip in `cat ips-v6`; do ufw allow from $cfip to any port 80; done
for cfip in `cat ips-v6`; do ufw allow from $cfip to any port 443; done

ufw enable
ufw reload > /dev/null

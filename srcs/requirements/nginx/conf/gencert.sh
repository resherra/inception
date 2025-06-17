#!/bin/sh
mkdir -p /certs
openssl req -x509 -newkey rsa:2048 -nodes -days 365 \
  -keyout /certs/server.key \
  -out /certs/server.crt \
  -subj "/CN=recherra.42.fr"

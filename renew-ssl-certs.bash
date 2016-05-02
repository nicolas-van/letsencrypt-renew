#!/bin/bash

service nginx stop
date >> /var/log/renew-ssl-certs.log
/root/letsencrypt/letsencrypt-auto renew >> /var/log/renew-ssl-certs.log 2>&1
service nginx start

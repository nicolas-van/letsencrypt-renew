#!/bin/bash

service nginx stop
echo >> /var/log/renew-ssl-certs.log
date >> /var/log/renew-ssl-certs.log
echo ============================= >> /var/log/renew-ssl-certs.lo
/root/letsencrypt/letsencrypt-auto renew >> /var/log/renew-ssl-certs.log 2>&1
service nginx start

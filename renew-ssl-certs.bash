#!/bin/bash

echo >> /var/log/renew-ssl-certs.log
date >> /var/log/renew-ssl-certs.log
echo ============================= >> /var/log/renew-ssl-certs.log
letsencrypt renew >> /var/log/renew-ssl-certs.log 2>&1
service nginx reload


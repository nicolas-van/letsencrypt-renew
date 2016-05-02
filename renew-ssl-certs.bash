#!/bin/bash

service nginx stop
date >> /var/log/renew.log
/root/letsencrypt/letsencrypt-auto renew >> /var/log/renew.log 2>&1
service nginx start

# letsencrypt-renew

Install Let's Encrypt and auto renew cron job:

    cd /root
    git clone https://github.com/letsencrypt/letsencrypt
    wget https://raw.githubusercontent.com/nicolas-van/letsencrypt-renew/master/renew-ssl-certs.bash
    chmod +x renew-ssl-certs.bash
    (crontab -l ; echo "@daily /root/renew-ssl-certs.bash")| crontab -
    
Register domain name:

    service nginx stop
    /root/letsencrypt/letsencrypt-auto certonly --standalone -d mydomain.com
    service nginx start

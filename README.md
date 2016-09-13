# letsencrypt-renew

This is a guide to install letsencrypt on Ubuntu 16.04 with autorenew using nginx as a web server and the webroot plugin.

Install Let's Encrypt and auto renew cron job:

    apt-get install letsencrypt
    mkdir /var/www/letsencrypt
    cd /root
    wget https://raw.githubusercontent.com/nicolas-van/letsencrypt-renew/master/renew-ssl-certs.bash
    chmod +x renew-ssl-certs.bash
    (crontab -l ; echo "@daily /root/renew-ssl-certs.bash")| crontab -
    
To register a domain first add these lines inside the `server` part of your nginx configuration:

    location ~ /.well-known {
        allow all;
        root /var/www/letsencrypt;
    }

Then type:

    letsencrypt certonly --webroot -w /var/www/letsencrypt -d ${your_domain_name}

The last step is to modify the nginx configuration:

    server {
        listen 80;
        server_name ${your_domain_name};
        rewrite ^ https://$server_name$request_uri? permanent;
    }

    server {
        listen 443 ssl;
        server_name ${your_domain_name};
    
        ssl_certificate /etc/letsencrypt/live/${your_domain_name}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${your_domain_name}/privkey.pem;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        
        ...
    }

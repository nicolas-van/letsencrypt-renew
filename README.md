# letsencrypt-renew

This is a guide to install letsencrypt on Ubuntu 16.04 with autorenew using nginx as a web server and the webroot plugin.

Install Let's Encrypt and auto renew cron job:

    apt-get install letsencrypt
    mkdir /var/www/letsencrypt
    cd /root
    wget https://raw.githubusercontent.com/nicolas-van/letsencrypt-renew/master/renew-ssl-certs.bash
    chmod +x renew-ssl-certs.bash
    (crontab -l ; echo "@daily /root/renew-ssl-certs.bash")| crontab -
    
To register a domain first add this to your nginx configuration (if you already have any nginx configuration related to your website just comment it for now):

    server {
        listen 80;
        server_name ${your_domain_name};
    
        location ~ /.well-known {
            allow all;
            root /var/www/letsencrypt;
        }
    
        location / {
            return 301 https://$server_name$request_uri;
        }
    }

Then type:

    letsencrypt certonly --webroot -w /var/www/letsencrypt -d ${your_domain_name}

The last step is to add the nginx configuration for your new ssl-enabled website:

    server {
        listen 443 ssl http2;
        server_name ${your_domain_name};
    
        ssl_certificate /etc/letsencrypt/live/${your_domain_name}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${your_domain_name}/privkey.pem;
        
        ...
        
        
    }
    
To test the autorenewal:

    letsencrypt renew --dry-run --agree-tos

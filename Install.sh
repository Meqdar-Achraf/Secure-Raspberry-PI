#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y

echo "=== installation ==="
sudo apt install -y openssh-server nginx ufw curl wireguard wireguard-tools libnss3-tools

echo "=== start services ==="
sudo systemctl enable ssh nginx
sudo systemctl start ssh nginx

echo "=== ssh backup ==="
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

echo "=== ssh config ==="
sudo sed -i "s/#Port 22/Port 2222/" /etc/ssh/sshd_config
sudo sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

echo "=== firewall ==="
sudo ufw allow 2222/tcp
sudo ufw allow 80/tcp
sudo ufw allow 53
sudo ufw allow 51820/udp
sudo ufw --force enable

sudo systemctl restart ssh

echo "=== nginx config ==="

curl -L -JLO https://dl.filippo.io/mkcert/latest?for=linux/amd64
chmod +x mkcert-*-linux-amd64
sudo mv mkcert-*-linux-amd64 /usr/local/bin/mkcert

mkcert -install
mkcert raspberry.localdomain

sudo mkdir -p /etc/nginx/ssl
sudo cp *.pem /etc/nginx/ssl/

cat <<'EOF' > /etc/nginx/sites-available/zabbix
server {
    listen 443 ssl;
    server_name raspberry.localdomain;

    ssl_certificate /etc/nginx/ssl/raspberry.localdomain.pem;
    ssl_certificate_key /etc/nginx/ssl/raspberry.localdomain-key.pem;

    location / {
        proxy_pass http://192.168.91.131/zabbix/;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/zabbix /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

echo "=== wireguard ==="

sudo mkdir -p /etc/wireguard
cd /etc/wireguard

wg genkey | tee server_private.key | wg pubkey > server_public.key

srv_priv=$(cat /etc/wireguard/server_private.key)

cat <<EOF > wg0.conf
[Interface]
PrivateKey = $srv_priv
Address = 10.0.0.1/24
ListenPort = 51820
SaveConfig = true

PostUp = ufw route allow in on wg0 out on eth0
PostDown = ufw route delete allow in on wg0 out on eth0
EOF

chmod 600 wg0.conf

sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0

echo "=== DONE ==="


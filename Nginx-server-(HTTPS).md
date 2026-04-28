# Guide de Configuration Nginx Reverse Proxy pour Zabbix - Configuration HTTP


## Installation

### Étape 1 : Mettre à jour les paquets système

```bash
sudo apt update
sudo apt upgrade -y
```

### Étape 2 : Installer Nginx

```bash
sudo apt install -y nginx
```

### Étape 3 : Vérifier l'installation

```bash
nginx -v
```

### Étape 4 : Démarrer et activer Nginx

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```
### Étape 5 : Intsallation de MKcert
```bash
sudo apt  install libnss3-tools -y
curl -JLO https://dl.filippo.io/mkcert/latest?for=linux/amd64
chmod +x mkcert-v*-linux-amd64
sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
```
### Étape 6 : Iniyialiser MKcert ⚠⚠⚠
```bash
mkcert -install
```

## Configuration

### Étape 1 : Générer un certificat pour ton domaine 
```bash
mkcert raspberry.localdomain    #pour ton domaine local
```
### Étape 2 : créer un répertoire pour les certificats 
```bash
sudo mkdir -p /etc/nginx/ssl
sudo cp *.pem /etc/nginx/ssl/
```

### Étape 3 : Créer le fichier de configuration Nginx

```bash
sudo nano /etc/nginx/sites-available/zabbix
```

### Étape 4 : Ajouter la configuration

Copiez et collez la configuration suivante.  :

```nginx
# Configuration Nginx Reverse Proxy pour Zabbix
server {
    listen 443 ssl;
    server_name raspberry.localdomain;

    ssl_certificate /etc/nginx/ssl/raspberry.localdomain.pem;
    ssl_certificate_key /etc/nginx/ssl/raspberry.localdomain-key.pem;

    ssl_protocols TLSv1.2 TLSv1.3;

    location / {

        limit_req zone=login_limit burst=10;

        proxy_pass http://<@-IP-zabbix>/zabbix/; #<@-IP-zabbix> = adresse IP de srv zabbix

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_read_timeout 90;
    }
}

# Rediriger HTTP → HTTPS
server {
    listen 80;
    server_name raspberry.localdomain;
    return 301 https://$host$request_uri;
}
```
### Étape 5 : Activer la configuration du site

Créez un lien symbolique pour activer le site :

```bash
sudo ln -s /etc/nginx/sites-available/zabbix /etc/nginx/sites-enabled/zabbix
```
### Étape 6 : Ajouter dans /etc/nginx/nginx.conf : 
```bash
http {
    limit_req_zone $binary_remote_addr zone=login_limit:10m rate=5r/m;

    ...
}
```

### Étape 4 : Tester la configuration Nginx

Avant de recharger, testez la syntaxe de la configuration :

```bash
sudo nginx -t
```

**Si vous voyez des erreurs, corrigez-les avant de passer à l'étape suivante.**

### Étape 5 : Recharger Nginx

```bash
sudo systemctl reload nginx
```

Vérifiez que le rechargement a réussi :

```bash
sudo systemctl status nginx
```

# Guide de Configuration Nginx Reverse Proxy pour Zabbix - Configuration HTTP


## Installation

### Étape 1 : Mettre à jour les paquets système

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### Étape 2 : Installer Nginx

```bash
sudo apt-get install -y nginx
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

## Configuration

### Étape 1 : Créer le fichier de configuration Nginx

```bash
sudo nano /etc/nginx/sites-available/zabbix
```

### Étape 2 : Ajouter la configuration

Copiez et collez la configuration suivante.  :

```nginx
# Configuration Nginx Reverse Proxy pour Zabbix
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://<ZABBIX_SERVER_IP>/zabbix/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

### Étape 3 : Activer la configuration du site

Créez un lien symbolique pour activer le site :

```bash
sudo ln -s /etc/nginx/sites-available/zabbix /etc/nginx/sites-enabled/zabbix
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

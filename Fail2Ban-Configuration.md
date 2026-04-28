# Configuration de Fail2Ban

Fail2Ban est un logiciel qui protège votre serveur contre les attaques par force brute en surveillant les journaux et en bloquant les adresses IP suspectes.

## Installation de Fail2Ban

1. **Mettre à jour votre système** : Assurez-vous que votre système est à jour avant d'installer Fail2Ban.
   
   ```bash
   sudo apt update
   sudo apt upgrade
   ```

2. **Installer Fail2Ban** : Utilisez le gestionnaire de paquets pour installer Fail2Ban.
   
   ```bash
   sudo apt install fail2ban
   ```

## Configuration de Fail2Ban

1. **Créer une copie de la configuration par défaut** : C'est une bonne pratique de ne pas modifier les fichiers de configuration par défaut.
   
   ```bash
   sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   ```

2. **Modifier le fichier de configuration `jail.local`** : Ouvrez le fichier avec un éditeur de texte. Par exemple, avec nano :
   
   ```bash
   sudo nano /etc/fail2ban/jail.local
   ```
   
   À l'intérieur, vous pouvez configurer les paramètres pour les services que vous souhaitez protéger. Par exemple, pour protéger SSH : 
   
   ```ini
```ini
# Configuration de Fail2Ban - DURCISSÉE
# Backend: systemd (recommandé pour les OS modernes)
# SSH: Port 2222 personnalisé
# Protection: SSH + Nginx (multiples jails)
# Whitelist: Réseau administration

[DEFAULT]
# Backend systemd pour meilleure performance et fiabilité
backend = systemd

# Paramètres de bannissement globaux
bantime = 600
findtime = 600
maxretry = 5  

# WHITELIST - Réseau local d'administration (À ADAPTER!)
# ⚠️ IMPORTANT: Remplacez 192.168.1.0/24 par votre plage réelle!
ignoreip = 127.0.0.1/8 ::1 192.168.31.0/24

# ============================================================
# PROTECTION SSH - Port personnalisé 2222
# ============================================================

[sshd]
enabled = true
port = 2222
filter = sshd
backend = systemd
logpath = %(syslog_backend)s
maxretry = 5
bantime = 600
findtime = 600

# ============================================================
# PROTECTION NGINX - Multiples Jails
# ============================================================

# Protection contre les attaques par force brute sur l'authentification HTTP
[nginx-http-auth]
enabled = true
port = http,https
filter = nginx-http-auth
logpath = /var/log/nginx/error.log
maxretry = 5
bantime = 600
findtime = 600

# Bloque les tentatives d'accès à des fichiers scripts inexistants
[nginx-noscript]
enabled = true
port = http,https
filter = nginx-noscript
logpath = /var/log/nginx/access.log
maxretry = 6
bantime = 600
findtime = 600

# Bloque les mauvais bots
[nginx-badbots]
enabled = true
port = http,https
filter = nginx-badbots
logpath = /var/log/nginx/access.log
maxretry = 2
bantime = 600
findtime = 600

# Bloque les tentatives de proxy non autorisées
[nginx-noproxy]
enabled = true
port = http,https
filter = nginx-noproxy
logpath = /var/log/nginx/access.log
maxretry = 2
bantime = 600
findtime = 600

# Protège contre les dépassements de limite de débit
[nginx-limit-req]
enabled = true
port = http,https
filter = nginx-limit-req
logpath = /var/log/nginx/error.log
maxretry = 5
bantime = 600
findtime = 600

# Détecte les scans de port
[nginx-port-scan]
enabled = true
port = http,https
filter = nginx-port-scan
logpath = /var/log/nginx/access.log
maxretry = 3
bantime = 600
findtime = 600
```

   ```

3. **Redémarrer le service Fail2Ban** : Appliquez les changements en redémarrant Fail2Ban.
   
   ```bash
   sudo systemctl restart fail2ban
   ```

## Vérification de l'état de Fail2Ban

Pour vérifier que Fail2Ban fonctionne correctement, utilisez la commande suivante :
   
```bash
sudo fail2ban-client status
```

Cela vous montrera l'état de Fail2Ban et les services qu'il surveille.
## 4. Gestion des adresses IP bannies

### Débannir une adresse IP

```bash
sudo fail2ban-client set sshd unbanip <adresse_ip>
```

### Bannir manuellement une adresse IP

```bash
sudo fail2ban-client set sshd banip <adresse_ip>
```

## 5. Surveillance des logs

Pour surveiller les activités de Fail2Ban en temps réel :

```bash
sudo tail -f /var/log/fail2ban.log
```

Pour voir les tentatives de connexion échouées :

```bash
sudo tail -f /var/log/auth.log
```

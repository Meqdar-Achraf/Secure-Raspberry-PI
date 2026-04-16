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
   [DEFAULT]
   bantime = 10m
   findtime = 10m
   maxretry = 5
   
   [sshd]
   enabled = true
   port = ssh
   filter = sshd
   logpath = /var/log/auth.log
   maxretry = 5
   bantime = 600
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

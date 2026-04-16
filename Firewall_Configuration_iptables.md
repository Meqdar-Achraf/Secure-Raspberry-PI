# Configuration du Pare-feu avec iptables


## Étape 1 : Installation d'iptables
Iptables est généralement préinstallé sur Raspberry. Pour vérifier son installation, exécutez :
```bash
sudo iptables -L
```
Si iptables n'est pas installé, vous pouvez l'installer avec la commande suivante :
```bash
sudo apt-get install iptables
```

Pour rendre les règles persistantes après redémarrage :
```bash
sudo apt install iptables-persistent -y
```

## Étape 2 : Configuration de règles de filtrage
### Bloquer tout le trafic
Par défaut, nous allons d'abord bloquer tout le trafic. Exécutez les commandes suivantes :
```bash
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP
```
### Autoriser le trafic essentiel
Autorisez le trafic essentiel comme SSH et HTTP :
```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS
```
Autotiser DNS
```bash
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT
```
## Règles avancées

### Bloquer une adresse IP
```bash
sudo iptables -A INPUT -s 192.168.1.50 -j DROP
```

### Bloquer un port spécifique

```bash
sudo iptables -A INPUT -p tcp --dport 3306 -j DROP
```


## Étape 3 : Sauvegarde de la configuration
Il est important de sauvegarder votre configuration :
```bash
sudo iptables-save > /etc/iptables/rules.v4
```

## Étape 4 : Restauration de la configuration
Pour restaurer la configuration, utilisez la commande suivante :
```bash
sudo iptables-restore < /etc/iptables/rules.v4
```

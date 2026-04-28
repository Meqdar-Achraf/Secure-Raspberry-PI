# Configuration du Pare-feu avec ufw


## Étape 1 : Installation du ufw
ufw est généralement préinstallé sur Raspberry. Pour vérifier son installation, exécutez :
```bash
sudo ufw status
```
Si ufw n'est pas installé, vous pouvez l'installer avec la commande suivante :
```bash
sudo apt install ufw -y
```


## Étape 2 : Configuration de règles de filtrage

### Autoriser le trafic essentiel
Autorisez le trafic essentiel comme SSH et HTTP :
```bash
sudo ufw allow 22/tcp  # SSH 
sudo ufw allow 80/tcp  # HTTP
sudo ufw allow 443/tcp # HTTPS


Autotiser DNS
```bash
sudo ufw allow out 53/tcp
sudo ufw allow out 53/udp
```

### Bloquer tout le trafic
Pour bloquer tout le trafic. Exécutez les commandes suivantes 
```bash
sudo ufw default deny incoming
sudo ufw default deny outgoing
sudo ufw default deny routed
```
## Règles avancées

### Bloquer une adresse IP
```bash
sudo ufw deny from 192.168.1.50
```

### Bloquer un port spécifique

```bash
sudo ufw dent 3306/tcp
```
### Autoriser un port spécifique
```bash
sudo ufw allow 51820/udp
```

## Étape 3 : activer ufw
pour activer le par-feu ufw.  Exécutez la commande suivante
```bash
sudo ufw enable
```

## Étape 4 : Vérifier que tout fonctionne
Pour vérifier que tout fonctionne bien, utilisez la commande suivante :
```bash
sudo ufw status verbose
```

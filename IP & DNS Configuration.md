# Configuration d'une adresse IP statique et des paramètres DNS


## Étape 1 : Identifier votre interface réseau

Avant de configurer une IP statique, identifiez votre interface réseau :

```bash
ifconfig
```

Les interfaces courantes sont :
- `eth0` : Connexion Ethernet filaire
- `wlan0` : Connexion Wi-Fi

## Étape 2 : Obtenir les informations réseau actuelles

Consultez votre configuration DHCP actuelle :

```bash
ip addr show
ip route show
cat /etc/resolv.conf
```

Notez les informations suivantes :
- Adresse IP actuelle
- Passerelle (Gateway)
- Serveurs DNS

## Étape 3 : Configurer une adresse IP statique via dhcpcd.conf

### Éditer le fichier dhcpcd.conf

```bash
sudo nano /etc/dhcpcd.conf
```

### Ajouter la configuration statique

À la fin du fichier, ajoutez les lignes suivantes pour configurer une IP statique sur Ethernet :

```bash
# Configuration IP statique pour Ethernet
interface eth0
static ip_address=192.168.31.95/24
static routers=192.168.31.1
static domain_name_servers=8.8.8.8 8.8.4.4
```

Ou pour Wi-Fi :

```bash
# Configuration IP statique pour Wi-Fi
interface wlan0
static ip_address=192.168.31.95/24
static routers=192.168.31.1
static domain_name_servers=8.8.8.8 8.8.4.4
```

### Explication des paramètres

- `interface` : L'interface réseau à configurer (eth0, wlan0, etc.)
- `static ip_address` : L'adresse IP statique avec le masque CIDR (ex: /24 pour 255.255.255.0)
- `static routers` : L'adresse de la passerelle par défaut
- `static domain_name_servers` : Les serveurs DNS (séparés par un espace)

### Sauvegarder et quitter

## Étape 4 : Redémarrer le service dhcpcd

Pour appliquer les modifications, redémarrez le service dhcpcd :

```bash
sudo systemctl restart dhcpcd
```

Ou redémarrez complètement votre Raspberry Pi :

```bash
sudo reboot
```

## Étape 5 : Vérifier la configuration

Vérifiez que l'adresse IP statique est bien configurée :

```bash
ip addr show
```

## Configuration DNS alternative via resolv.conf

### Éditer resolv.conf

```bash
sudo nano /etc/resolv.conf
```

### Ajouter les serveurs DNS

```bash
# Exemple avec Google DNS
nameserver 8.8.8.8
nameserver 8.8.4.4
```

## Vérifier la résolution DNS

Testez votre configuration DNS :

```bash
nslookup google.com
```

ou

```bash
dig google.com
```

Configurer une adresse IP statique et des paramètres DNS personnalisés est essentiel pour un Raspberry Pi utilisé en production. En suivant ce guide, vous assurerez une stabilité réseau et une meilleure sécurité pour votre système de surveillance.

# Configuration d'une adresse IP statique et des paramètres DNS

## Détection de la version Raspberry Pi OS

Avant de configurer votre réseau, identifiez votre version de Raspberry Pi OS :

```bash
cat /etc/os-release
# ou
lsb_release -a
```

- **Raspberry Pi OS Bullseye et antérieur** : Utilisez la méthode `dhcpcd`
- **Raspberry Pi OS Bookworm et ultérieur** : Utilisez la méthode `NetworkManager` (recommandé)

## Étape 1 : Identifier votre interface réseau

Avant de configurer une IP statique, identifiez votre interface réseau :

```bash
ifconfig
```

Les interfaces courantes sont :
- `eth0` ou `enp*` : Connexion Ethernet filaire
- `wlan0` ou `wlp*` : Connexion Wi-Fi

## Étape 2 : Obtenir les informations réseau actuelles

Consultez votre configuration DHCP actuelle :

```bash
ip addr show
ip route show
cat /etc/resolv.conf
nmcli device show  # Sur Bookworm avec NetworkManager
```

Notez les informations suivantes :
- Adresse IP actuelle
- Passerelle (Gateway)
- Serveurs DNS

---

# Méthode 1 : NetworkManager (Raspberry Pi OS Bookworm - Recommandé)

## Étape 1 : Vérifier l'installation de NetworkManager

```bash
sudo systemctl status NetworkManager
```

Si NetworkManager n'est pas installé :

```bash
sudo apt-get update
sudo apt-get install -y network-manager
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

## Étape 2 : Vérifier les connexions existantes

```bash
nmcli connection show
nmcli device show
```

## Étape 3 : Configurer une IP statique pour Ethernet

### Via ligne de commande

```bash
# Lister les connexions disponibles
nmcli connection show

# Créer ou modifier une connexion Ethernet
sudo nmcli connection modify "Wired connection 1" \
  ipv4.addresses "192.168.31.95/24" \
  ipv4.gateway "192.168.31.1" \
  ipv4.dns "8.8.8.8 8.8.4.4" \
  ipv4.method manual

# Activer la connexion
sudo nmcli connection up "Wired connection 1"
```

### Via fichier de configuration

Créez un fichier de configuration pour Ethernet :

```bash
sudo nano /etc/NetworkManager/conf.d/99-static-ethernet.conf
```

Ajoutez la configuration suivante :

```ini
# Configuration IP statique pour Ethernet
[device]
match-device=interface_name:eth0
```

Ensuite, créez la connexion :

```bash
sudo nano /etc/NetworkManager/system-connections/Wired-connection-static.nmconnection
```

Ajoutez :

```ini
[connection]
id=Wired-Static
uuid=12345678-1234-1234-1234-123456789012
type=802-3-ethernet
interface-name=eth0
autoconnect=true

[ipv4]
method=manual
addresses=192.168.31.95/24
gateway=192.168.31.1
dns=8.8.8.8;8.8.4.4;
dns-search=

[ipv6]
method=auto

[proxy]
```

Définir les permissions correctes :

```bash
sudo chmod 600 /etc/NetworkManager/system-connections/Wired-connection-static.nmconnection
sudo systemctl restart NetworkManager
```

## Étape 4 : Configurer une IP statique pour Wi-Fi

### Via ligne de commande

```bash
# Lister les réseaux Wi-Fi disponibles
nmcli device wifi list

# Créer une connexion Wi-Fi
sudo nmcli connection add type wifi ifname wlan0 con-name "WiFi-Static" ssid "YOUR_SSID"

# Configurer l'IP statique
sudo nmcli connection modify "WiFi-Static" \
  ipv4.addresses "192.168.31.95/24" \
  ipv4.gateway "192.168.31.1" \
  ipv4.dns "8.8.8.8 8.8.4.4" \
  ipv4.method manual

# Configurer la sécurité Wi-Fi
sudo nmcli connection modify "WiFi-Static" \
  wifi-sec.key-mgmt wpa-psk \
  wifi-sec.psk "YOUR_PASSWORD"

# Activer la connexion
sudo nmcli connection up "WiFi-Static"
```

## Étape 5 : Vérifier la configuration (NetworkManager)

```bash
# Vérifier le statut de la connexion
nmcli connection show
nmcli device show eth0

# Vérifier l'adresse IP
ip addr show
ip route show

# Tester la connectivité
ping 8.8.8.8
nslookup google.com
```

# Méthode 2 : dhcpcd (Raspberry Pi OS Bullseye et antérieur - Alternative)

## Note
Cette méthode est principalement pour les anciennes versions. NetworkManager est recommandé pour Bookworm.

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

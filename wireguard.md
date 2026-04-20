# Guide d'Installation et Déploiement d'un Serveur VPN WireGuard

## Installation



```bash
sudo apt-get install -y wireguard wireguard-tools
```

## Configuration du Serveur

### Étape 1 : Générer les clés du serveur

```bash
wg genkey | tee server_private.key | wg pubkey > server_public.key
```

Affichez les clés générées :

```bash
cat server_private.key
cat server_public.key
```

### Étape 2 : Créer le fichier de configuration du serveur

Créez le fichier de configuration :

```bash
sudo nano /etc/wireguard/wg0.conf
```

```ini
# Configuration du Serveur WireGuard VPN
[Interface]
# Adresse IP interne du serveur VPN
Address = 10.6.0.1/24
# Port d'écoute UDP
ListenPort = 51820
# Clé privée du serveur
PrivateKey = <SERVER_PRIVATE_KEY>
SaveConfig = false
```

### Étape 3 : Définir les permissions

```bash
sudo chmod 600 /etc/wireguard/wg0.conf
```

### Étape 4 : Générer les clés des clients

Pour client, générez une paire de clés :

```bash
wg genkey | tee client1_private.key | wg pubkey > client1_public.key
```

### Étape 5 : Ajouter le client au serveur

Modifiez le fichier de configuration du serveur :

```bash
sudo nano /etc/wireguard/wg0.conf
```

Ajoutez une section `[Peer]` pour chaque client:

```ini
# Client 1
[Peer]
PublicKey = <CLIENT1_PUBLIC_KEY>
AllowedIPs = 10.6.0.2/32

# Client 2
[Peer]
PublicKey = <CLIENT2_PUBLIC_KEY>
AllowedIPs = 10.6.0.3/32
```

---

### Configuration du Pare-feu

Activez le pare-feu s'il ne l'est pas :

```bash
sudo ufw enable
```

Autorisez le trafic WireGuard :

```bash
sudo ufw allow 51820/udp
```
---

## Démarrage et Gestion du Serveur

### Étape 1 : Activer et démarrer WireGuard

```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

### Étape 2 : Vérifier le statut

```bash
sudo systemctl status wg-quick@wg0
```

### Étape 3 : Afficher les informations WireGuard

```bash
sudo wg show
```

Vous devriez voir le serveur et tous les clients connectés.

---

## Configuration des Clients

### Linux/Mac

Créez un fichier `client1.conf` :

```ini
# Configuration Client WireGuard
[Interface]
PrivateKey = <CLIENT1_PRIVATE_KEY>
Address = 10.6.0.2/32
DNS = 8.8.8.8, 8.8.4.4

[Peer]
PublicKey = <SERVER_PUBLIC_KEY>
Endpoint = <SERVER_PUBLIC_IP>:51820
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25
```

Importez la configuration :

```bash
sudo wg-quick up ./client1.conf
```

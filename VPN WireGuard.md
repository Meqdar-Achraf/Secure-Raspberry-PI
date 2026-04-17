# Déployer un serveur VPN WireGuard

## Étape 1: Mise à jour de votre système
Avant de commencer, mettez à jour votre système avec les commandes suivantes:
```bash
sudo apt update
sudo apt upgrade -y
```

## Étape 2: Installation de WireGuard
Installez WireGuard avec la commande suivante:
```bash
sudo apt install wireguard -y
```

## Étape 3: Configuration de WireGuard
Créez une clé privée et publique pour votre serveur:
```bash
wg genkey | tee server_private.key | wg pubkey > server_public.key
```

## Étape 4: Configuration du fichier de configuration
Créez un fichier de configuration pour WireGuard:
```bash
sudo nano /etc/wireguard/wg0.conf
```
Ajoutez le contenu suivant, en remplaçant `YourServerPrivateKey` et `YourServerIPAddress` par les valeurs appropriées:
```
[Interface]
PrivateKey = YourServerPrivateKey
Address = 10.0.0.1/24
ListenPort = 51820

[Peer]
PublicKey = YourClientPublicKey
AllowedIPs = 10.0.0.2/32
```

## Étape 5: Lancement de WireGuard
Activez et démarrez le service WireGuard:
```bash
sudo systemctl start wg-quick@wg0
sudo systemctl enable wg-quick@wg0
```

## Verifying the VPN Connection

### Step 6: Connection Verification
To verify that the VPN connection between client and server is active, you can use the following commands:

1. Run `wg show` on the server to check the status of the WireGuard interface. This command displays information about the connections, including the peers and their endpoints.

2. Optionally, use the `ping` command to test connectivity to the client from the server, or vice versa. For example:
   ```bash
   ping <client-ip-address>
   ```

### Step 7: Client Setup
To set up the client for connecting to the VPN, follow these steps:

1. **Key Generation**: Use the following command to generate a new private and public key:
   ```bash
   wg genkey | tee privatekey | wg pubkey > publickey
   ```
   Store these keys securely.

2. **Configuration File Creation**: Create a WireGuard configuration file (e.g., `wg0.conf`) with the following content:
   ```ini
   [Interface]
   PrivateKey = <client-private-key>
   Address = <client-ip-address>
   DNS = <dns-server-ip>

   [Peer]
   PublicKey = <server-public-key>
   Endpoint = <server-ip-address>:<port>
   AllowedIPs = 0.0.0.0/0
   PersistentKeepalive = 25
   ```

3. **Connection Testing Procedures**: Start the WireGuard interface using:
   ```bash
   wg-quick up wg0
   ```
   Then, verify the connection by using `wg show` and checking if the handshake is successful. You can also run the ping command again to ensure connectivity.

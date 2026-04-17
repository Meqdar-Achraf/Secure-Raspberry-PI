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

## Conclusion
Vous avez maintenant déployé un serveur WireGuard sur votre Raspberry Pi! Assurez-vous de configurer vos clients WireGuard avec la clé publique du serveur et de tester la connexion.

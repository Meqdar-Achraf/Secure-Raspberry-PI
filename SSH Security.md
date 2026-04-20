# Sécurité SSH

Secure Shell (SSH) est un protocole pour accéder de manière sécurisée aux serveurs sur un réseau. Assurer de bonnes pratiques de sécurité SSH est essentiel pour protéger votre système contre les accès non autorisés. Voici les étapes clés pour [...]

## 1. Installer SSH
1. Pour installer SSH sur le Raspberry Pi et le démarrer, exécutez les commandes suivantes :
   ```bash
   sudo apt install openssh-server -y
   sudo systemctl start ssh
   sudo systemctl enable ssh 
   ```

## 2. Générer des clés publiques
L'authentification par clé publique est plus sécurisée que l'utilisation de mots de passe. Pour générer une paire de clés publique-privée :

1. Ouvrez un terminal sur votre machine locale.
2. Exécutez la commande suivante :
   ```bash
   ssh-keygen 
   ```
3. Appuyez sur Entrée pour accepter l'emplacement du fichier par défaut ou spécifiez un emplacement différent.
4. Définissez une phrase de passe pour une couche de sécurité supplémentaire (facultatif).

Pour copier votre clé publique vers le Raspberry Pi :
```bash
ssh-copy-id nom_utilisateur@adresse_ip_raspberry_pi
```
Remplacez `adresse_ip_raspberry_pi` par l'adresse IP de votre Raspberry Pi.

## 3. Changer le port SSH
Changer le port SSH par défaut (22) peut aider à réduire le risque d'attaques automatisées.

1. Ouvrez le fichier de configuration SSH :
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
2. Trouvez la ligne qui dit `#Port 22` et changez-la en :
   ```bash
   Port 2222
   ```
   Remplacez `2222` par le numéro de port que vous préférez.
3. Autorisez le nouveau port sur le pare-feu
      ```bash
   sudo ufw allow 2222/tcp
   ```
   ou
      ```bash
   sudo iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
   ```
4. Enregistrez le fichier et redémarrez le service SSH :
   ```bash
   sudo systemctl restart ssh
   ```
Assurez-vous d'ajuster les paramètres de votre pare-feu pour autoriser les connexions au nouveau port.

## 4. Désactiver le compte root
Désactiver la connexion root via SSH ajoute une couche de sécurité supplémentaire :

1. Ouvrez le fichier de configuration SSH :
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
2. Trouvez la ligne qui dit `PermitRootLogin yes` et changez-la en :
   ```bash
   PermitRootLogin no
   ```
3. Enregistrez le fichier et redémarrez le service SSH :
   ```bash
   sudo systemctl restart ssh
   ```

## Conclusion
En suivant ces étapes, vous pouvez considérablement améliorer la sécurité de vos connexions SSH et protéger votre Raspberry Pi contre les accès non autorisés. Gardez toujours votre système et vos logiciels à jour pour [...]

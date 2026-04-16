# Configuration d'une adresse IP statique et des paramètres DNS sur Raspberry Pi

## Introduction
Configurer une adresse IP statique et les paramètres DNS sur un Raspberry Pi peut améliorer la stabilité de votre réseau. Cela permet à des dispositifs réseau, comme les ordinateurs ou les serveurs, de se connecter à votre Raspberry Pi à chaque fois à la même adresse IP.

## Étape 1 : Éditer le fichier /etc/dhcpcd.conf

1. **Ouvrez le terminal sur votre Raspberry Pi.**  

2. **Utilisez l'éditeur de texte de votre choix** (par exemple, nano) pour ouvrir le fichier `dhcpcd.conf` :  
   ```bash
   sudo nano /etc/dhcpcd.conf
   ```  

3. **Ajoutez les lignes suivantes à la fin du fichier**. Remplacez `xxx` par vos valeurs spécifiques :  
   ```bash
   interface eth0  # ou wlan0 pour le Wi-Fi
   static ip_address=192.168.1.xxx/24  # Remplacez avec votre adresse IP
   static routers=192.168.1.1  # Remplacez avec l'adresse IP de votre routeur
   static domain_name_servers=192.168.1.1  # Votre serveur DNS
   ```  

4. **Enregistrez le fichier** et fermez l'éditeur (dans nano : Ctrl + X, puis Y et Entrée).

5. **Redémarrez votre Raspberry Pi** pour appliquer les modifications :  
   ```bash
   sudo reboot
   ```

## Étape 2 : Éditer le fichier /etc/resolv.conf

1. **Ouvrez le fichier `resolv.conf`** :  
   ```bash
   sudo nano /etc/resolv.conf
   ```  

2. **Ajoutez les serveurs DNS** de votre choix. Par exemple :  
   ```bash
   nameserver 8.8.8.8  # Google DNS
   nameserver 8.8.4.4  # Google DNS
   ```  

3. **Enregistrez le fichier** et fermez l'éditeur.

## Conclusion
Votre Raspberry Pi est maintenant configuré avec une adresse IP statique et les paramètres DNS. Cela assurera une connexion réseau stable et fiable.
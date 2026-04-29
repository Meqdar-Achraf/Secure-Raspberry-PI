# Secure Raspberry PI ()

## Table des matières

1. [Project Overview](#project-overview)
2. [Diagramme d'Architecture Réseau](#diagramme-darchitecture-réseau)
3. [Prérequis](#prérequis)
4. [Contenu du dépôt](#contenu-du-dépôt)
5. [Objectifs du projet](#objectifs-du-projet)
6. [Quick Start - Guide pas-à-pas](#quick-start---guide-pas-à-pas)
7. [Configuration avancée](#configuration-avancée)
8. [Support et troubleshooting](#support-et-troubleshooting)

---

## Project Overview  

Ce projet vise à renforcer la sécurité des appareils Raspberry Pi en mettant en œuvre diverses mesures de sécurité, notamment la sécurisation de SSH, la configuration du pare-feu et le déploiement d'outils de surveillance. 

**Objectif principal :** Fournir une solution complète de sécurisation et de supervision pour les déploiements Raspberry Pi en environnement de production.

---

## Diagramme d'Architecture Réseau

```
┌─────────────────────────────────────────────────────────────────┐
│                         RÉSEAU LOCAL                            │
│                    (192.168.31.0/24)                            │
└─────────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┼─────────┐
                    │         │         │
                    ▼         ▼         ▼
        ┌─────────────────┐  ┌──────────────────┐
        │  Routeur/Box    │  │   Autre Devices  │
        │ (192.168.31.1)  │  │   (DHCP/Static)  │
        └────────┬────────┘  └──────────────────┘
                 │
         ┌───────┴──────┬──────────────┐
         │              │              │
         ▼              ▼              ▼
    ┌──────────┐  ┌──────────┐  ┌──────────┐
    │ RPi Main │  │Ubuntu    │  │ RPi      │
    │ (Secure) │  │Monitoring│  │ Other    │
    │192.168.  │  │192.168.  │  │192.168.  │
    │31.xx     │  │31.xx     │  │31.xx     │
    └──────────┘  └──────────┘  └──────────┘
         │              │              │
    ┌────┴────┐     ┌────┴────┐   ┌────┴────┐
    │ SSH     │     │ Zabbix  │   │ Ansible │
    │ Firewall│     │ Agent   │   │ Managed │
    │ Fail2Ban│     │         │   │ Nodes   │
    └─────────┘     └─────────┘   └─────────┘
```

### Composants principaux :

- **RPi Main (Principal)** : Serveur de sécurité centralisé avec SSH renforcé, pare-feu iptables, Fail2Ban
- **RPi Monitoring** : Agent de supervision Zabbix pour collecte des métriques
- **RPi Other** : Nœuds gérés via Ansible pour déploiement automatisé

---

## Prérequis

### Matériels requis

- **Raspberry Pi** (modèle 3B+ ou superieur recommandé)
  - Processeur : ARM Cortex-A53 ou supérieur
  - RAM : 1 GB minimum (2 GB recommandé pour supervision)
  - Stockage : Carte microSD (Clé USB) 16 GB minimum (32 GB recommandé)
  
- **Alimentation** : Adaptateur 5V/2.5A ou supérieur
- **Connectivité réseau** : 
  - Ethernet (recommandé pour stabilité) ou Wi-Fi
  - Accès Internet pour les mises à jour
- **Équipement de débuggage** :
  - Câble USB-A vers Micro-USB (optionnel, pour accès direct)
  - HDMI + Écran (optionnel, pour configuration initiale)
  - Clavier/Souris (optionnel)

### Logiciels requis

- **Système d'exploitation** :
  - Raspberry Pi OS Bookworm (dernière version recommandée)
  - ou Raspberry Pi OS Bullseye (si matériel plus ancien)
  
- **Prérequis système** :
  ```bash
  # Architecture système
  - Architecture : ARM (32-bit) ou ARM64 (64-bit)
  - Kernel : Linux 5.4 minimum
  - Init system : systemd
  ```

- **Outils requis** :
  - `sudo` : Accès administrateur
  - `bash` : Environnement shell (v4.0+)
  - `apt` / `apt-get` : Gestionnaire de paquets
  - `nano` ou `vi` : Éditeur de texte
  - `git` : Contrôle de version (optionnel, pour clonage du dépôt)

- **Services optionnels futurs** :
  - **Zabbix Agent** : Pour la supervision (fichiers dédiés à venir)
  - **Ansible** : Pour l'orchestration (playbooks à venir)

### Connexion réseau recommandée

```bash
# Identifier votre interface réseau
ifconfig

# Interfaces courantes :
# eth0  : Ethernet filaire (recommandé)
# wlan0 : Wi-Fi (acceptable)
```

### Droits d'accès

- Accès SSH avec clés publiques/privées configurées
- Droits `sudo` pour l'utilisateur de déploiement
- Pas d'accès root direct recommandé

---

## Contenu du dépôt  

### 📁 Structure actuelle

- **Sécurité SSH** : Bonnes pratiques pour sécuriser l'accès SSH au Raspberry Pi, y compris l'authentification par clé et la désactivation de la connexion root.  

- **Configuration du pare-feu (iptables)** : Directives pour configurer iptables afin de contrôler efficacement le trafic entrant et sortant.  

- **Configuration de Fail2Ban** : Instructions pour utiliser Fail2Ban afin de prévenir les accès non autorisés en bloquant les adresses IP après un certain nombre de tentatives de connexion échouées.  

- **Configuration IP & DNS** : Stratégies pour configurer des adresses IP statiques et les paramètres DNS afin d'assurer une connectivité réseau fiable.  

- **Outils d'analyse réseau** : Outils et techniques pour analyser le trafic réseau et identifier les menaces potentielles.

- **Script d'audit** : `Check-security.sh` pout auditer la mashine.

- **Supervision Zabbix** : Configuration et intégration d'agents Zabbix pour monitoring .

- **Playbook Ansible** : Automatisation du déploiement et de la configuration.

- **Scripts d'installation** : `install.sh` pour déploiement simplifié est automatisé.

---

## Objectifs du projet  

- ✅ Faire évoluer les mesures actuelles de sécurité réseau pour les déploiements Raspberry Pi.  
- ✅ Renforcer la sécurité des systèmes de surveillance basés sur Raspberry Pi, en garantissant l'intégrité et la confidentialité des données.  
- 🔄 Ajouter capacités de supervision centralisée avec Zabbix
- 🔄 Automatiser le déploiement avec Ansible
- 🔄 Simplifier l'installation avec des scripts natifs

---

## Quick Start - Guide pas-à-pas

### Étape 1 : Préparer votre Raspberry Pi

```bash
# 1. Connectez-vous à votre RPi
ssh pi@192.168.31.xx

# 2. Mettez à jour le système
sudo apt-get update
sudo apt-get upgrade -y

# 3. Vérifiez votre version de Raspberry Pi OS
cat /etc/os-release
```

### Étape 2 : Cloner le dépôt (optionnel avec git)

```bash
# Clonez le dépôt Secure-Raspberry-PI
git clone https://github.com/Meqdar-Achraf/Secure-Raspberry-PI.git
cd Secure-Raspberry-PI

# Listez les fichiers disponibles
ls -la
```

### Étape 3 : Configuration réseau (IP statique)

Pour une configuration robuste en production, configurez une IP statique :

```bash
# Identifiez votre interface réseau
ifconfig

# Consultez le guide détaillé
cat IP_DNS-Configuration.md

# Exemple rapide pour Bookworm (NetworkManager)
sudo nmcli connection modify "Wired connection 1" \
  ipv4.addresses "192.168.31.xx/24" \
  ipv4.gateway "192.168.31.1" \
  ipv4.dns "8.8.8.8 8.8.4.4" \
  ipv4.method manual

sudo nmcli connection up "Wired connection 1"

# Vérifiez la configuration
ip addr show
ping 8.8.8.8
```

### Étape 4 : Sécurisation SSH

```bash
# Créez une paire de clés (sur votre machine locale si elle n'existe pas)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa

# Copiez la clé publique sur le RPi
ssh-copy-id -i ~/.ssh/id_rsa.pub pi@192.168.31.95

# Connectez-vous et modifiez la configuration SSH
ssh pi@192.168.31.95
sudo nano /etc/ssh/sshd_config

# Modifications recommandées :
# PermitRootLogin no
# PasswordAuthentication no
# PubkeyAuthentication yes
# Port 22 (ou autre port sécurisé)

# Redémarrez SSH
sudo systemctl restart sshd
```

### Étape 5 : Configuration du pare-feu (iptables)

```bash
# Consultez les guides de sécurité disponibles
# Les scripts iptables seront ajoutés dans les dossiers de configuration

sudo apt-get ufw
sudo ufw status

sudo ufw enable
```

### Étape 6 : Installation de Fail2Ban

```bash
# Installez Fail2Ban
sudo apt-get install -y fail2ban

# Activez et démarrez le service
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Vérifiez l'état
sudo systemctl status fail2ban
```

### Étape 7 : Vérification finale

```bash
# Vérifiez que tous les services sont en cours d'exécution
sudo systemctl status ssh
sudo systemctl status fail2ban
sudo systemctl status NetworkManager  # ou dhcpcd selon votre version

# Testez la connectivité
ping -c 4 google.com
nslookup google.com

# Vérifiez les logs de sécurité
sudo tail -f /var/log/auth.log
```

---

## Configuration avancée

### Supervision avec Zabbix

*Guide détaillé à venir dans le dossier `Zabbix/`*

```bash
# Installation rapide de l'agent Zabbix (à automatiser)
sudo apt-get install -y zabbix-agent
```

### Orchestration avec Ansible

*Playbooks à venir dans le dossier `Ansible/`*

```bash
# Déploiement automatisé sur plusieurs RPi
ansible-playbook -i inventory.ini playbooks/install.yml
```

### Déploiement automatisé

*Script d'installation global à venir*

```bash
# Installation complète en une commande
./install.sh
```

---

## Support et troubleshooting

### Problèmes courants

#### Impossible de se connecter en SSH
```bash
# Vérifiez que SSH est en cours d'exécution
sudo systemctl status ssh

# Consultez les logs
sudo tail -f /var/log/auth.log

# Vérifiez les permissions des clés
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

#### Problèmes de connectivité réseau
```bash
# Vérifiez la configuration IP
ip addr show
ip route show

# Testez la résolution DNS
nslookup google.com
dig google.com

# Consultez le guide complet
cat IP_DNS-Configuration.md
```

#### Fail2Ban ne bloque pas les adresses
```bash
# Vérifiez le statut
sudo fail2ban-client status

# Consultez les logs
sudo tail -f /var/log/fail2ban.log
```

### Ressources additionnelles

- **Documentation Raspberry Pi** : https://www.raspberrypi.org/documentation/
- **NetworkManager** : https://networkmanager.dev/
- **Fail2Ban** : https://www.fail2ban.org/
- **Zabbix Documentation** : https://www.zabbix.com/documentation
- **Installation Zabbix** : https://www.zabbix.com/download
- **Docuùentation Linux** : https://doc.clinux.fr/

---

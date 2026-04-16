# Outils d'analyse réseau

## Introduction
Les outils d'analyse réseau sont essentiels pour surveiller, dépanner et analyser le trafic réseau et les connexions. Dans ce document, nous couvrirons quatre outils importants : **Nmap**, **Netstat**, **Wireshark** et **Tcpdump**.

## Nmap
Nmap (Network Mapper) est un outil open-source conçu pour l'exploration de réseau et l'audit de sécurité.
- **Caractéristiques :**
  - Découverte d'hôtes
  - Scan de ports
  - Détection de version de service
  - Détection d'OS

### Installer Nmap
```bash
sudo apt install nmap -y
```

### Utilisation de base
Pour scanner un hôte pour les ports ouverts, vous pouvez utiliser la commande suivante :
```bash
nmap <adresse_ip_cible>
```

### Exemple
```bash
nmap 192.168.1.1
```

## Netstat
Netstat est un utilitaire en ligne de commande qui affiche les statistiques de mise en réseau et les connexions.
- **Caractéristiques :**
  - Affiche les connexions actives
  - Affiche les ports en écoute
  - Fournit les tables de routage

### Installer Netstat
```bash
sudo apt install net-tools -y
```

### Utilisation de base
Pour afficher les connexions TCP actuelles :
```bash
netstat -tn
```

## Wireshark
Wireshark est un analyseur de protocole réseau largement utilisé qui permet aux utilisateurs de capturer et de parcourir interactivement le trafic.
- **Caractéristiques :**
  - Capture de paquets
  - Analyse du trafic en direct
  - Inspection détaillée des paquets

### Installer Wireshark
```bash
sudo apt install wireshark -y
```

### Utilisation de base
Pour commencer à capturer des paquets :
1. Ouvrez Wireshark.
2. Sélectionnez l'interface réseau à capturer.
3. Cliquez sur "Démarrer".

### Exemple
Capturez le trafic HTTP en entrant le filtre :
```plaintext
http
```

## Tcpdump
Tcpdump est un puissant analyseur de paquets en ligne de commande. Il permet aux utilisateurs d'afficher et d'analyser les paquets de manière concise.
- **Caractéristiques :**
  - Capture des paquets sur une interface réseau
  - Peut sortir dans des fichiers pour une analyse ultérieure

### Installer Tcpdump
```bash
sudo apt install tcpdump -y
```

### Utilisation de base
Pour capturer des paquets :
```bash
tcpdump -i <interface>
```

### Exemple
```bash
tcpdump -i eth0
```

## Conclusion
Comprendre ces outils améliorera votre capacité à analyser le trafic réseau, à diagnostiquer les problèmes et à améliorer les performances globales du réseau. Chaque outil a ses forces et ses cas d'usage, et ils peuvent souvent être utilisés ensemble pour fournir des informations complètes sur le comportement du réseau.

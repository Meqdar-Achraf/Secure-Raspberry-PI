# Configuration du Pare-feu avec iptables

## Introduction
Ce document fournit des instructions détaillées pour configurer et installer un pare-feu sur un Raspberry Pi à l'aide d'iptables. Cela inclut des règles de filtrage strictes pour sécuriser votre dispositif.

## Prérequis
Avant de commencer, assurez-vous d'avoir :
- Un Raspberry Pi fonctionnel avec Raspbian installé.
- Un accès terminal à votre Raspberry Pi.
- Les droits d'administrateur (sudo).

## Étape 1 : Installation d'iptables
Iptables est généralement préinstallé sur Raspbian. Pour vérifier son installation, exécutez :
```bash
sudo iptables -L
```
Si iptables n'est pas installé, vous pouvez l'installer avec la commande suivante :
```bash
sudo apt-get install iptables
```

## Étape 2 : Configuration de règles de filtrage
### Bloquer tout le trafic
Par défaut, nous allons d'abord bloquer tout le trafic. Exécutez les commandes suivantes :
```bash
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP
```
### Autoriser le trafic essentiel
Autorisez le trafic essentiel comme SSH et HTTP :
```bash
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS
```

## Étape 3 : Sauvegarde de la configuration
Il est important de sauvegarder votre configuration :
```bash
sudo iptables-save > /etc/iptables/rules.v4
```

## Étape 4 : Restauration de la configuration
Pour restaurer la configuration, utilisez la commande suivante :
```bash
sudo iptables-restore < /etc/iptables/rules.v4
```

## Conclusion
En suivant ces étapes, vous aurez configuré un pare-feu strict sur votre Raspberry Pi à l'aide d'iptables. Assurez-vous de tester vos règles pour garantir que vos services sont accessibles comme prévu.
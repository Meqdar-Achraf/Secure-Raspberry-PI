#!/bin/bash

REPORT="/var/log/security_audit_report.txt"
DATE=$(date)

# Create / reset report
echo "================ SECURITY AUDIT REPORT ================" > $REPORT
echo "Date: $DATE" >> $REPORT
echo "=======================================================" >> $REPORT
echo "" >> $REPORT

echo "[1] 🔥 Firewall Status (UFW)" >> $REPORT
if command -v ufw >/dev/null 2>&1; then
    sudo ufw status verbose >> $REPORT
else
    echo "❌ UFW not installed" >> $REPORT
fi
echo "" >> $REPORT

echo "[2] 🌐 Open Ports" >> $REPORT
ss -tuln >> $REPORT
echo "" >> $REPORT

echo "[3] 🔐 SSH Security Configuration" >> $REPORT
if [ -f /etc/ssh/sshd_config ]; then
    grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config >> $REPORT
else
    echo "❌ SSH config not found" >> $REPORT
fi
echo "" >> $REPORT

echo "[4] 👤 Logged Users" >> $REPORT
who >> $REPORT
echo "" >> $REPORT

echo "[5] 🧑 System Users (Potential Risk Check)" >> $REPORT
cut -d: -f1 /etc/passwd >> $REPORT
echo "" >> $REPORT

echo "[6] 📦 System Updates Status" >> $REPORT
if command -v apt >/dev/null 2>&1; then
    echo "Checking updates..." >> $REPORT
    sudo apt update -qq >> $REPORT 2>&1
    apt list --upgradable >> $REPORT
else
    echo "Package manager not supported" >> $REPORT
fi
echo "" >> $REPORT

echo "[7] ⚠️ Sudo Users" >> $REPORT
getent group sudo >> $REPORT
echo "" >> $REPORT

echo "[8] 📊 Disk Usage" >> $REPORT
df -h >> $REPORT
echo "" >> $REPORT



echo "================ END OF REPORT ================" >> $REPORT

echo "✅ Security audit completed!"
echo "📄 Report saved in: $REPORT"

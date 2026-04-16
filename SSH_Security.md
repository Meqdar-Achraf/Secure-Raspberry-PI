# SSH Security

Secure Shell (SSH) is a protocol for securely accessing servers over a network. Ensuring good SSH security practices is critical to protect your system from unauthorized access. Here are key steps to enhance SSH security on your Raspberry Pi:

## 1. Generating Public Keys
Using public key authentication is more secure than using passwords. To generate a public-private key pair:

1. Open a terminal on your local machine.
2. Run the following command:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   Replace `your_email@example.com` with your email address.
3. Press Enter to accept the default file location or specify a different one.
4. Set a passphrase for an added layer of security (optional).

To copy your public key to the Raspberry Pi:
```bash
ssh-copy-id pi@your_raspberry_pi_ip
```
Replace `your_raspberry_pi_ip` with the Raspberry Pi's IP address.

## 2. Changing SSH Port
Changing the default SSH port (22) can help reduce the risk of automated attacks.

1. Open the SSH configuration file:
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
2. Find the line that says `#Port 22` and change it to:
   ```bash
   Port 2222
   ```
   Replace `2222` with your preferred port number.
3. Save the file and restart the SSH service:
   ```bash
   sudo systemctl restart ssh
   ```
Make sure to adjust your firewall settings to allow connections to the new port.

## 3. Disabling Root Account
Disabling root login via SSH adds an extra layer of security:

1. Open the SSH configuration file:
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
2. Find the line that says `PermitRootLogin yes` and change it to:
   ```bash
   PermitRootLogin no
   ```
3. Save the file and restart the SSH service:
   ```bash
   sudo systemctl restart ssh
   ```

## Conclusion
By following these steps, you can significantly enhance the security of your SSH connections and protect your Raspberry Pi from unauthorized access. Always keep your system and software updated to safeguard against vulnerabilities.
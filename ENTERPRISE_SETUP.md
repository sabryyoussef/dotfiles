# 🏢 Odoo Enterprise Setup Guide

Complete guide for setting up Odoo Enterprise alongside Community editions for versions 16, 17, 18, and 19.

## 🔒 Prerequisites

1. **Odoo Enterprise Access**: You need valid credentials for the private Odoo Enterprise repository
2. **GitHub Access Token**: Create a Personal Access Token with `repo` scope
   - Go to: https://github.com/settings/tokens
   - Create token with `repo` access
   - Save it securely (you'll need it once)

## 📦 Directory Structure

Your final structure will be:

```
~/odoo_dev/
├── odoo_16/              # Community
│   ├── odoo-bin
│   ├── odoo16.conf       # Community config
│   └── odoo16e.conf      # Enterprise config
├── enterprise_16/        # Enterprise modules
│
├── odoo_17/
│   ├── odoo-bin
│   ├── odoo17.conf
│   └── odoo17e.conf
├── enterprise_17/
│
├── odoo_18/
│   ├── odoo-bin
│   ├── odoo18.conf
│   └── odoo18e.conf
├── enterprise_18/
│
├── odoo_19/
│   ├── odoo-bin
│   ├── odoo19.conf
│   └── odoo19e.conf
└── enterprise_19/
```

## 🚀 Installation Steps

### 1. Clone Community Editions (if not already done)

```bash
cd ~/odoo_dev

# Odoo 16
git clone https://github.com/odoo/odoo.git -b 16.0 odoo_16

# Odoo 17
git clone https://github.com/odoo/odoo.git -b 17.0 odoo_17

# Odoo 18
git clone https://github.com/odoo/odoo.git -b 18.0 odoo_18

# Odoo 19 (master branch)
git clone https://github.com/odoo/odoo.git -b master odoo_19
```

### 2. Clone Enterprise Editions

**Using HTTPS (with Personal Access Token):**

```bash
cd ~/odoo_dev

# Odoo 16 Enterprise
git clone https://github.com/odoo/enterprise.git -b 16.0 enterprise_16

# Odoo 17 Enterprise
git clone https://github.com/odoo/enterprise.git -b 17.0 enterprise_17

# Odoo 18 Enterprise
git clone https://github.com/odoo/enterprise.git -b 18.0 enterprise_18

# Odoo 19 Enterprise (master branch)
git clone https://github.com/odoo/enterprise.git -b master enterprise_19
```

**Using SSH (if you have SSH keys configured):**

```bash
cd ~/odoo_dev

git clone git@github.com:odoo/enterprise.git -b 16.0 enterprise_16
git clone git@github.com:odoo/enterprise.git -b 17.0 enterprise_17
git clone git@github.com:odoo/enterprise.git -b 18.0 enterprise_18
git clone git@github.com:odoo/enterprise.git -b master enterprise_19
```

### 3. Create Enterprise Configuration Files

For each version, create an Enterprise-specific config file:

**Example: `~/odoo_dev/odoo_18/odoo18e.conf`**

```ini
[options]
# Paths - CRITICAL: Include both Community and Enterprise addons
addons_path = /home/sabry3/odoo_dev/odoo_18/addons,/home/sabry3/odoo_dev/enterprise_18

# Data directory
data_dir = /home/sabry3/.local/share/Odoo18e

# Database settings
admin_passwd = your_secure_admin_password
db_host = localhost
db_port = 5432
db_user = odoo
db_password = odoo

# Server settings
xmlrpc_port = 8069
# For running multiple versions: use 8016, 8017, 8018, 8019

# Logging
logfile = /var/log/odoo/odoo18e.log
log_level = info

# Performance
workers = 4
max_cron_threads = 2
```

**Repeat for all versions** (adjust paths and ports accordingly):
- `odoo_16/odoo16e.conf` → port 8016
- `odoo_17/odoo17e.conf` → port 8017
- `odoo_18/odoo18e.conf` → port 8018
- `odoo_19/odoo19e.conf` → port 8019

### 4. Create Log Directories

```bash
sudo mkdir -p /var/log/odoo
sudo chown $USER:$USER /var/log/odoo
```

### 5. Install Dependencies

```bash
# For each Odoo version, install Python dependencies
cd ~/odoo_dev/odoo_18
pip3 install -r requirements.txt

# Repeat for 16, 17, 19
```

## 🎯 Using the Aliases

After running `source ~/.bashrc`, you'll have these aliases available:

### Community Aliases
```bash
o16      # Run Odoo 16 Community
o17      # Run Odoo 17 Community
o18      # Run Odoo 18 Community
o19      # Run Odoo 19 Community
```

### Enterprise Aliases
```bash
o16e     # Run Odoo 16 Enterprise
o17e     # Run Odoo 17 Enterprise
o18e     # Run Odoo 18 Enterprise
o19e     # Run Odoo 19 Enterprise
```

### Navigation Aliases
```bash
cd16     # Go to Odoo 16 Community
cde16    # Go to Odoo 16 Enterprise
cd17     # Go to Odoo 17 Community
cde17    # Go to Odoo 17 Enterprise
# ... and so on
```

### PostgreSQL Aliases
```bash
p16      # Connect to Odoo 16 Community DB
p16e     # Connect to Odoo 16 Enterprise DB
p17      # Connect to Odoo 17 Community DB
p17e     # Connect to Odoo 17 Enterprise DB
# ... and so on
```

### Upgrade Aliases
```bash
up16     # Upgrade all modules in Odoo 16 Community
up16e    # Upgrade all modules in Odoo 16 Enterprise
up17     # Upgrade all modules in Odoo 17 Community
up17e    # Upgrade all modules in Odoo 17 Enterprise
# ... and so on
```

## 🔄 Updating Enterprise Code

To pull the latest Enterprise updates:

```bash
cd ~/odoo_dev/enterprise_18
git pull origin 18.0

# Or for all versions at once:
cd ~/odoo_dev
for ver in 16 17 18 19; do
  cd enterprise_$ver && git pull && cd ..
done
```

## 🔒 Security Best Practices

### 1. Protect Your Credentials

Store your GitHub token securely:

```bash
# Store in Git credential helper (recommended)
git config --global credential.helper store

# Or use SSH keys instead of tokens
```

### 2. Add to .gitignore

If you create any custom projects that might reference Enterprise:

```bash
# In your custom addon repos, add:
echo "enterprise_*/" >> .gitignore
```

### 3. Never Commit Enterprise Code

```bash
# NEVER do this:
git add enterprise_18/
git commit -m "Adding Enterprise modules"  # ❌ LICENSE VIOLATION

# Enterprise code stays LOCAL only
```

### 4. Access Control

```bash
# Limit who can access Enterprise directories
chmod 700 ~/odoo_dev/enterprise_*
```

## 🧪 Testing Your Setup

### 1. Test Community Version

```bash
o18
# Should start Odoo 18 Community on http://localhost:8069
```

### 2. Test Enterprise Version

```bash
o18e
# Should start Odoo 18 Enterprise with all Enterprise modules available
```

### 3. Verify Enterprise Modules

1. Open browser: http://localhost:8069
2. Go to Apps → Remove "Apps" filter
3. Search for "Studio" or "Accounting" or "MRP"
4. You should see Enterprise-only modules

## 🐛 Troubleshooting

### Issue: "Could not find Enterprise modules"

**Check addons_path in config file:**
```bash
grep addons_path ~/odoo_dev/odoo_18/odoo18e.conf
```

Should show both paths:
```
addons_path = /home/sabry3/odoo_dev/odoo_18/addons,/home/sabry3/odoo_dev/enterprise_18
```

### Issue: "Authentication failed" when cloning

**Solution 1: Use Personal Access Token**
```bash
# When prompted for password, use your GitHub Personal Access Token
# NOT your GitHub password
```

**Solution 2: Configure Git credential helper**
```bash
git config --global credential.helper store
```

**Solution 3: Use SSH instead**
```bash
# Setup SSH keys first: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
git clone git@github.com:odoo/enterprise.git -b 18.0 enterprise_18
```

### Issue: Port already in use

**Solution: Use different ports for each version**

Edit each config file:
```ini
# odoo16e.conf
xmlrpc_port = 8016

# odoo17e.conf
xmlrpc_port = 8017

# odoo18e.conf
xmlrpc_port = 8018

# odoo19e.conf
xmlrpc_port = 8019
```

### Issue: Permission denied on log files

```bash
sudo mkdir -p /var/log/odoo
sudo chown -R $USER:$USER /var/log/odoo
```

## 📚 Additional Resources

- [Odoo Installation Documentation](https://www.odoo.com/documentation/18.0/administration/install.html)
- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Odoo Configuration File Reference](https://www.odoo.com/documentation/18.0/developer/reference/cli.html)

## ✅ Checklist

- [ ] Community editions cloned (16, 17, 18, 19)
- [ ] Enterprise editions cloned (16, 17, 18, 19)
- [ ] Enterprise config files created (odoo16e.conf, odoo17e.conf, etc.)
- [ ] Log directories created and permissions set
- [ ] Python dependencies installed
- [ ] Dotfiles installed (`~/dotfiles/install.sh`)
- [ ] Bashrc reloaded (`source ~/.bashrc`)
- [ ] Tested Community aliases (o16, o17, o18, o19)
- [ ] Tested Enterprise aliases (o16e, o17e, o18e, o19e)
- [ ] Verified Enterprise modules visible in Apps menu

---

**🎉 You're now ready for enterprise-grade Odoo development!**

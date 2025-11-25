# 🗄️ Odoo Database Automation Guide

Complete automation for Odoo database management using the pattern: **database_name = database_user = database_password**

## 🎯 The Pattern

Instead of managing separate credentials, we use one name for everything:

```bash
Database: odoo18
User:     odoo18
Password: odoo18
```

This works for any name:
- `odoo18`, `freezoner_17`, `smartview_19`, `client_production_16`

## 🔧 Setup

### 1. Environment Variables (Required)

Set these in your environment before using the tools:

**For GitHub Codespaces:**
Go to https://github.com/settings/codespaces and add these secrets:

- `ODOO_DB_HOST` = `localhost` (or your PostgreSQL host)
- `ODOO_DB_SUPERUSER` = `postgres` (PostgreSQL superuser)
- `ODOO_DB_SUPERPASSWORD` = your PostgreSQL superuser password

**For Local Development:**

```bash
# Add to ~/.bashrc or ~/.zshrc
export ODOO_DB_HOST="localhost"
export ODOO_DB_SUPERUSER="postgres"
export ODOO_DB_SUPERPASSWORD="your_postgres_password"
```

### 2. Install Dotfiles

```bash
cd ~/dotfiles
./install.sh
source ~/.bashrc
```

This loads:
- `odoo_aliases.sh` - All Odoo version aliases
- `odoo_db_tools.sh` - Database management functions
- `git_config.sh` - Git configuration

## 🚀 Quick Start

### Create Database & Environment

```bash
# Create database, user, and password all named "odoo18"
mkdb odoo18

# Activate environment variables
envdb odoo18

# Run Odoo 18 Community
o18
```

### Real-World Example

```bash
# Create database for client project
mkdb freezoner_17

# Activate that environment
envdb freezoner_17

# Run Odoo 17 Enterprise
o17e
```

## 📚 Available Commands

### Database Management

| Command | Function | Example |
|---------|----------|---------|
| `mkdb <name>` | Create database, user, password | `mkdb odoo18` |
| `envdb <name>` | Activate environment for a database | `envdb odoo18` |
| `listdb` | List all Odoo databases | `listdb` |
| `dropdb <name>` | Delete database and user | `dropdb old_project` |

### What `mkdb` Does

1. Creates PostgreSQL role with name = password
2. Creates database owned by that role
3. Idempotent (safe to run multiple times)
4. Shows clear success message

Example output:
```
🔧 Creating Odoo environment: odoo18
   Host: localhost
📝 Creating role: odoo18
✅ Role created: odoo18
📝 Creating database: odoo18
✅ Database created: odoo18

✅ Created DB/User/Password = odoo18

💡 Next steps:
   1. Activate environment: envdb odoo18
   2. Run Odoo with your aliases (o16, o17e, etc.)
```

### What `envdb` Does

Exports these environment variables:

```bash
export ODOO_DB_NAME="odoo18"
export ODOO_DB_USER="odoo18"
export ODOO_DB_PASSWORD="odoo18"
```

Example output:
```
🔧 Odoo Environment Activated
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Database:  odoo18
User:      odoo18
Password:  odoo18
Host:      localhost
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 These variables are now exported for Odoo config files
   Run your Odoo alias: o16, o17, o18, o19, o16e, o17e, o18e, o19e
```

## 🔧 Odoo Configuration

### Using Environment Variables in Config Files

Your Odoo config files can now use environment variables:

**Example: `~/odoo_dev/odoo_18/odoo18.conf`**

```ini
[options]
# Use environment variables set by 'envdb'
addons_path = /home/sabry3/odoo_dev/odoo_18/addons
data_dir = /home/sabry3/.local/share/Odoo18

# Database connection - uses exported environment variables
db_host = ${ODOO_DB_HOST}
db_name = ${ODOO_DB_NAME}
db_user = ${ODOO_DB_USER}
db_password = ${ODOO_DB_PASSWORD}

# Or use the --database flag when running:
# o18 --database=odoo18 --db-filter=^odoo18$

# Server settings
xmlrpc_port = 8018
logfile = /var/log/odoo/odoo18.log
```

**Note:** Odoo doesn't natively support `${VAR}` syntax in config files. Instead, you have two options:

### Option 1: Use Command-Line Arguments (Recommended)

```bash
# After envdb odoo18, use:
$ODOO18/odoo-bin --config=$ODOO18/odoo18.conf \
    --database=$ODOO_DB_NAME \
    --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER \
    --db_password=$ODOO_DB_PASSWORD
```

### Option 2: Create Dynamic Config Files

Create a wrapper script that generates config files:

```bash
#!/bin/bash
# generate-odoo-config.sh

cat > ~/odoo_dev/odoo_18/odoo18.conf << EOF
[options]
addons_path = /home/sabry3/odoo_dev/odoo_18/addons
db_host = ${ODOO_DB_HOST}
db_name = ${ODOO_DB_NAME}
db_user = ${ODOO_DB_USER}
db_password = ${ODOO_DB_PASSWORD}
xmlrpc_port = 8018
EOF
```

### Option 3: Enhanced Aliases (Recommended)

We'll update your aliases to use environment variables automatically.

Add this to your `~/.bashrc` or create enhanced wrapper scripts:

```bash
# Enhanced alias that uses environment variables
o18_env() {
    if [ -z "$ODOO_DB_NAME" ]; then
        echo "❌ No database environment set. Run: envdb <name>"
        return 1
    fi
    
    $ODOO18/odoo-bin \
        --config=$ODOO18/odoo18.conf \
        --database=$ODOO_DB_NAME \
        --db_host=$ODOO_DB_HOST \
        --db_user=$ODOO_DB_USER \
        --db_password=$ODOO_DB_PASSWORD \
        "$@"
}
```

## 📋 Complete Workflow Examples

### Example 1: New Development Database

```bash
# 1. Create database environment
mkdb odoo18_dev

# 2. Activate environment
envdb odoo18_dev

# 3. Run Odoo
o18 --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD

# Or with Enterprise
o18e --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD
```

### Example 2: Client Project (Enterprise)

```bash
# 1. Create database for client
mkdb freezoner_17

# 2. Activate that environment
envdb freezoner_17

# 3. Navigate to Odoo 17
cd17

# 4. Run with Enterprise modules
o17e --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD
```

### Example 3: Multiple Databases (Switching)

```bash
# Create multiple databases
mkdb project_alpha
mkdb project_beta
mkdb project_gamma

# Switch between them
envdb project_alpha
o18 --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD

# Switch to another
envdb project_beta
o18 --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD

# List all databases
listdb
```

### Example 4: Cleanup Old Databases

```bash
# List databases
listdb

# Remove old database (with confirmation)
dropdb old_project_2023
```

## 🛠️ Advanced Features

### List All Databases

```bash
listdb
```

Output:
```
📊 Odoo Databases on localhost:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Database      | Owner      | Size    
---------------+------------+---------
 freezoner_17  | freezoner  | 245 MB
 odoo18        | odoo18     | 128 MB
 odoo19_test   | odoo19     | 89 MB
```

### Idempotent Operations

All operations are safe to run multiple times:

```bash
# First run - creates everything
mkdb odoo18

# Second run - skips existing items
mkdb odoo18
# Output:
# ℹ️  Role 'odoo18' already exists
# ℹ️  Database 'odoo18' already exists
```

### Database Deletion with Safety

```bash
dropdb odoo18
# Prompts for confirmation:
# ⚠️  WARNING: This will permanently delete database 'odoo18'
# Are you sure? (yes/no):
```

## 🔒 Security Best Practices

### 1. Never Hardcode Passwords

❌ **Bad:**
```ini
[options]
db_password = hardcoded_password
```

✅ **Good:**
```bash
envdb my_database
# Uses environment variables
```

### 2. Use GitHub Secrets in Codespaces

Don't commit `ODOO_DB_SUPERPASSWORD` to any file. Always use:
- GitHub Codespaces Secrets (for cloud)
- Local environment variables (for local development)

### 3. .gitignore Database Credentials

Add to your `.gitignore`:
```
*.conf
*.conf.backup
.env
.env.local
```

### 4. Different Passwords for Production

For production, use strong passwords:

```bash
# Development (simple pattern)
mkdb odoo18_dev

# Production (manual setup with strong password)
# Don't use the pattern for production!
```

## 🐛 Troubleshooting

### Error: "ODOO_DB_SUPERPASSWORD not set"

**Solution:**
```bash
export ODOO_DB_SUPERPASSWORD="your_postgres_password"
```

Or add to `~/.bashrc` permanently.

### Error: "role already exists"

This is normal! The script is idempotent. It means the database/user already exists.

### Error: "could not connect to server"

Check if PostgreSQL is running:
```bash
sudo systemctl status postgresql
# Or
pg_isready -h localhost
```

### Error: "permission denied"

Check your superuser credentials:
```bash
# Test connection
psql -h localhost -U postgres -c "SELECT version();"
```

## 📊 Comparison: Old vs New Workflow

### Old Workflow ❌

```bash
# 1. Manually create user
psql -U postgres -c "CREATE USER myuser WITH PASSWORD 'complex_pass';"

# 2. Manually create database
psql -U postgres -c "CREATE DATABASE mydb OWNER myuser;"

# 3. Edit config file
nano ~/odoo_dev/odoo_18/odoo18.conf
# db_name = mydb
# db_user = myuser  
# db_password = complex_pass

# 4. Remember to use correct config
~/odoo_dev/odoo_18/odoo-bin -c ~/odoo_dev/odoo_18/odoo18.conf
```

### New Workflow ✅

```bash
mkdb mydb
envdb mydb
o18 --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST \
    --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD
```

**Benefits:**
- ⚡ 3 commands vs 4+ manual steps
- 🔒 No passwords in files
- 🚀 Idempotent & safe
- 🎯 Consistent naming
- 📝 No config file editing needed

## ✅ Checklist

After setup, verify everything works:

- [ ] Environment variables set (`ODOO_DB_HOST`, `ODOO_DB_SUPERUSER`, `ODOO_DB_SUPERPASSWORD`)
- [ ] Dotfiles installed (`./install.sh`)
- [ ] Can create database (`mkdb test_db`)
- [ ] Can activate environment (`envdb test_db`)
- [ ] Can list databases (`listdb`)
- [ ] Can run Odoo with environment (`o18 --database=$ODOO_DB_NAME ...`)
- [ ] Can delete database (`dropdb test_db`)

## 🎓 Summary

**Pattern:** `database_name = database_user = database_password`

**Core Commands:**
- `mkdb <name>` - Create everything
- `envdb <name>` - Activate environment
- `listdb` - View all databases
- `dropdb <name>` - Clean up

**Workflow:**
1. Create: `mkdb project_name`
2. Activate: `envdb project_name`
3. Run: `o18 --database=$ODOO_DB_NAME --db_host=$ODOO_DB_HOST --db_user=$ODOO_DB_USER --db_password=$ODOO_DB_PASSWORD`

**Perfect for:**
- ✅ GitHub Codespaces
- ✅ Local Ubuntu development
- ✅ Multiple Odoo versions (16, 17, 18, 19)
- ✅ Multiple clients/projects
- ✅ Quick database switching

---

**🎉 Your Odoo database management is now fully automated!**

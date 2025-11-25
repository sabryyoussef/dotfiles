# 🚀 Dotfiles for Odoo Multi-Version Development

Enterprise-grade dotfiles configuration for Odoo developers working with multiple Odoo versions (16, 17, 18, 19) in GitHub Codespaces or any Linux environment.

## 📁 Structure

```
dotfiles/
├── install.sh              # Main installation script
├── README.md               # This file
└── shell/
    ├── odoo_aliases.sh     # Odoo version-specific aliases
    └── git_config.sh       # Git global configuration
```

## ⚡ Quick Start

### In GitHub Codespaces

1. **Set up your dotfiles repo** in GitHub settings:
   - Go to: https://github.com/settings/codespaces
   - Under "Dotfiles", enable: `Automatically install dotfiles`
   - Repository: `sabryyoussef/dotfiles`

2. **Create a new Codespace** - dotfiles will auto-install!

### Manual Installation

```bash
# Clone the repo
git clone https://github.com/sabryyoussef/dotfiles.git ~/dotfiles

# Run installation
cd ~/dotfiles
chmod +x install.sh
./install.sh

# Apply changes
source ~/.bashrc
```

## 🎯 Features

### Odoo Version Management

Predefined aliases for working with multiple Odoo versions simultaneously:

**Run Odoo:**
- `o16` - Run Odoo 16
- `o17` - Run Odoo 17
- `o18` - Run Odoo 18
- `o19` - Run Odoo 19

**Navigate:**
- `cd16` - Go to Odoo 16 directory
- `cd17` - Go to Odoo 17 directory
- `cd18` - Go to Odoo 18 directory
- `cd19` - Go to Odoo 19 directory

**PostgreSQL Access:**
- `p16` - Connect to Odoo 16 database
- `p17` - Connect to Odoo 17 database
- `p18` - Connect to Odoo 18 database
- `p19` - Connect to Odoo 19 database

**Module Updates:**
- `up16` - Update all modules in Odoo 16
- `up17` - Update all modules in Odoo 17
- `up18` - Update all modules in Odoo 18
- `up19` - Update all modules in Odoo 19

### Git Configuration

Automatically configures:
- User identity (Sabry / vendorah2@gmail.com)
- Performance optimizations for Codespaces
- Sensible defaults (main branch, pull strategy)

## 🛠️ Customization

### Change Odoo Base Path

Edit `shell/odoo_aliases.sh`:

```bash
export ODOO_BASE="$HOME/your_custom_path"
```

### Adjust Database Names

Edit the PostgreSQL aliases in `shell/odoo_aliases.sh`:

```bash
alias p16='psql -h localhost -U your_user -d your_db'
```

### Modify Git Settings

Edit `shell/git_config.sh` with your preferences.

## 📦 Expected Directory Structure

The aliases expect the following Odoo directory structure:

```
~/odoo_dev/
├── odoo_16/
│   ├── odoo-bin
│   └── odoo16.conf
├── odoo_17/
│   ├── odoo-bin
│   └── odoo17.conf
├── odoo_18/
│   ├── odoo-bin
│   └── odoo18.conf
└── odoo_19/
    ├── odoo-bin
    └── odoo19.conf
```

## ✅ Verification

After installation, verify everything works:

```bash
# Check if aliases are loaded
type o16

# Test navigation
cd16
pwd

# Check Git config
git config --global user.name
```

## 🔧 Troubleshooting

**Aliases not working?**
```bash
source ~/.bashrc
```

**Need to reinstall?**
```bash
cd ~/dotfiles
./install.sh
source ~/.bashrc
```

**Want to uninstall?**
Edit `~/.bashrc` and remove the lines added by the installer (marked with comments).

## 🚀 Advanced Usage

### Add More Aliases

Edit `shell/odoo_aliases.sh` and add your custom aliases:

```bash
# Custom restart alias
alias restart16="o16 --stop-after-init"

# Database backup
alias backup16="pg_dump -U odoo odoo16 > backup_$(date +%Y%m%d).sql"
```

Then reload:
```bash
source ~/.bashrc
```

## 📝 License

MIT License - Feel free to customize for your needs!

## 👤 Author

**Sabry Youssef**
- Email: vendorah2@gmail.com
- GitHub: [@sabryyoussef](https://github.com/sabryyoussef)

---

**💡 Pro Tip:** This setup is idempotent - you can run `install.sh` multiple times safely!

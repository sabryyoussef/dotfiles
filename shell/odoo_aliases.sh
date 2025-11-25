#!/usr/bin/env bash

# ---------------------------
# Odoo Development Aliases
# ---------------------------

# Base paths — customize if needed
export ODOO_BASE="$HOME/odoo_dev"

# Odoo version paths
export ODOO16="$ODOO_BASE/odoo_16"
export ODOO17="$ODOO_BASE/odoo_17"
export ODOO18="$ODOO_BASE/odoo_18"
export ODOO19="$ODOO_BASE/odoo_19"

# Run commands
alias o16="$ODOO16/odoo-bin -c $ODOO16/odoo16.conf"
alias o17="$ODOO17/odoo-bin -c $ODOO17/odoo17.conf"
alias o18="$ODOO18/odoo-bin -c $ODOO18/odoo18.conf"
alias o19="$ODOO19/odoo-bin -c $ODOO19/odoo19.conf"

# Navigate to folders
alias cd16='cd $ODOO16'
alias cd17='cd $ODOO17'
alias cd18='cd $ODOO18'
alias cd19='cd $ODOO19'

# PostgreSQL helpers (adjust DB names if needed)
alias p16='psql -h localhost -U odoo -d odoo16'
alias p17='psql -h localhost -U odoo -d odoo17'
alias p18='psql -h localhost -U odoo -d odoo18'
alias p19='psql -h localhost -U odoo -d odoo19'

# Upgrade shortcuts
alias up16="$ODOO16/odoo-bin -c $ODOO16/odoo16.conf -u all"
alias up17="$ODOO17/odoo-bin -c $ODOO17/odoo17.conf -u all"
alias up18="$ODOO18/odoo-bin -c $ODOO18/odoo18.conf -u all"
alias up19="$ODOO19/odoo-bin -c $ODOO19/odoo19.conf -u all"

echo "✅ Odoo aliases loaded (versions 16, 17, 18, 19)"

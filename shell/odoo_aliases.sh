#!/usr/bin/env bash

# ---------------------------
# Odoo Development Aliases
# ---------------------------

# Base paths — customize if needed
export ODOO_BASE="$HOME/odoo_dev"

# Odoo version paths (Community)
export ODOO16="$ODOO_BASE/odoo_16"
export ODOO17="$ODOO_BASE/odoo_17"
export ODOO18="$ODOO_BASE/odoo_18"
export ODOO19="$ODOO_BASE/odoo_19"

# Enterprise paths
export ENTERPRISE16="$ODOO_BASE/enterprise_16"
export ENTERPRISE17="$ODOO_BASE/enterprise_17"
export ENTERPRISE18="$ODOO_BASE/enterprise_18"
export ENTERPRISE19="$ODOO_BASE/enterprise_19"

# Run commands (Community)
alias o16="$ODOO16/odoo-bin -c $ODOO16/odoo16.conf"
alias o17="$ODOO17/odoo-bin -c $ODOO17/odoo17.conf"
alias o18="$ODOO18/odoo-bin -c $ODOO18/odoo18.conf"
alias o19="$ODOO19/odoo-bin -c $ODOO19/odoo19.conf"

# Run commands (Enterprise)
alias o16e="$ODOO16/odoo-bin -c $ODOO16/odoo16e.conf"
alias o17e="$ODOO17/odoo-bin -c $ODOO17/odoo17e.conf"
alias o18e="$ODOO18/odoo-bin -c $ODOO18/odoo18e.conf"
alias o19e="$ODOO19/odoo-bin -c $ODOO19/odoo19e.conf"

# Navigate to folders (Community)
alias cd16='cd $ODOO16'
alias cd17='cd $ODOO17'
alias cd18='cd $ODOO18'
alias cd19='cd $ODOO19'

# Navigate to folders (Enterprise)
alias cde16='cd $ENTERPRISE16'
alias cde17='cd $ENTERPRISE17'
alias cde18='cd $ENTERPRISE18'
alias cde19='cd $ENTERPRISE19'

# PostgreSQL helpers (adjust DB names if needed)
alias p16='psql -h localhost -U odoo -d odoo16'
alias p17='psql -h localhost -U odoo -d odoo17'
alias p18='psql -h localhost -U odoo -d odoo18'
alias p19='psql -h localhost -U odoo -d odoo19'

# PostgreSQL helpers (Enterprise databases)
alias p16e='psql -h localhost -U odoo -d odoo16e'
alias p17e='psql -h localhost -U odoo -d odoo17e'
alias p18e='psql -h localhost -U odoo -d odoo18e'
alias p19e='psql -h localhost -U odoo -d odoo19e'

# Upgrade shortcuts (Community)
alias up16="$ODOO16/odoo-bin -c $ODOO16/odoo16.conf -u all"
alias up17="$ODOO17/odoo-bin -c $ODOO17/odoo17.conf -u all"
alias up18="$ODOO18/odoo-bin -c $ODOO18/odoo18.conf -u all"
alias up19="$ODOO19/odoo-bin -c $ODOO19/odoo19.conf -u all"

# Upgrade shortcuts (Enterprise)
alias up16e="$ODOO16/odoo-bin -c $ODOO16/odoo16e.conf -u all"
alias up17e="$ODOO17/odoo-bin -c $ODOO17/odoo17e.conf -u all"
alias up18e="$ODOO18/odoo-bin -c $ODOO18/odoo18e.conf -u all"
alias up19e="$ODOO19/odoo-bin -c $ODOO19/odoo19e.conf -u all"

echo "✅ Odoo aliases loaded (Community + Enterprise: versions 16, 17, 18, 19)"

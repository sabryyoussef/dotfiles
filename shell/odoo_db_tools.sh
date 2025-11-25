#!/usr/bin/env bash

# ---------------------------
# Odoo Database Tools
# ---------------------------
# Implements the pattern: database_name = database_user = database_password
# Works with GitHub Codespaces secrets and local environments

# Database infrastructure secrets (should be set in environment)
# ODOO_DB_HOST - PostgreSQL host (default: localhost)
# ODOO_DB_SUPERUSER - PostgreSQL superuser (default: postgres)
# ODOO_DB_SUPERPASSWORD - PostgreSQL superuser password

# Set defaults if not provided
export ODOO_DB_HOST="${ODOO_DB_HOST:-localhost}"
export ODOO_DB_SUPERUSER="${ODOO_DB_SUPERUSER:-postgres}"

# Function: create_odoo_env
# Creates a PostgreSQL database, user, and password all with the same name
# Usage: create_odoo_env <db_name>
# Example: create_odoo_env odoo18
create_odoo_env() {
    local db_name="$1"
    
    if [ -z "$db_name" ]; then
        echo "❌ Error: Database name required"
        echo "Usage: create_odoo_env <db_name>"
        echo "Example: create_odoo_env odoo18"
        return 1
    fi
    
    if [ -z "$ODOO_DB_SUPERPASSWORD" ]; then
        echo "❌ Error: ODOO_DB_SUPERPASSWORD environment variable not set"
        echo "Set it in GitHub Codespaces secrets or export it locally"
        return 1
    fi
    
    echo "🔧 Creating Odoo environment: $db_name"
    echo "   Host: $ODOO_DB_HOST"
    
    # Check if role already exists
    local role_exists
    role_exists=$(PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -tAc "SELECT 1 FROM pg_roles WHERE rolname='$db_name'" 2>/dev/null)
    
    if [ "$role_exists" = "1" ]; then
        echo "ℹ️  Role '$db_name' already exists"
    else
        echo "📝 Creating role: $db_name"
        PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -c "CREATE ROLE \"$db_name\" WITH LOGIN PASSWORD '$db_name' CREATEDB;" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "✅ Role created: $db_name"
        else
            echo "❌ Failed to create role: $db_name"
            return 1
        fi
    fi
    
    # Check if database already exists
    local db_exists
    db_exists=$(PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -tAc "SELECT 1 FROM pg_database WHERE datname='$db_name'" 2>/dev/null)
    
    if [ "$db_exists" = "1" ]; then
        echo "ℹ️  Database '$db_name' already exists"
    else
        echo "📝 Creating database: $db_name"
        PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -c "CREATE DATABASE \"$db_name\" OWNER \"$db_name\";" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "✅ Database created: $db_name"
        else
            echo "❌ Failed to create database: $db_name"
            return 1
        fi
    fi
    
    echo ""
    echo "✅ Created DB/User/Password = $db_name"
    echo ""
    echo "💡 Next steps:"
    echo "   1. Activate environment: envdb $db_name"
    echo "   2. Run Odoo with your aliases (o16, o17e, etc.)"
}

# Function: use_odoo_env
# Sets environment variables for a specific Odoo database
# Usage: use_odoo_env <db_name>
# Example: use_odoo_env odoo18
use_odoo_env() {
    local db_name="$1"
    
    if [ -z "$db_name" ]; then
        echo "❌ Error: Database name required"
        echo "Usage: use_odoo_env <db_name>"
        echo "Example: use_odoo_env odoo18"
        return 1
    fi
    
    # Export environment variables
    export ODOO_DB_NAME="$db_name"
    export ODOO_DB_USER="$db_name"
    export ODOO_DB_PASSWORD="$db_name"
    
    echo "🔧 Odoo Environment Activated"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Database:  $ODOO_DB_NAME"
    echo "User:      $ODOO_DB_USER"
    echo "Password:  $ODOO_DB_PASSWORD"
    echo "Host:      $ODOO_DB_HOST"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "💡 These variables are now exported for Odoo config files"
    echo "   Run your Odoo alias: o16, o17, o18, o19, o16e, o17e, o18e, o19e"
}

# Function: list_odoo_dbs
# Lists all databases owned by non-superuser roles (likely Odoo databases)
list_odoo_dbs() {
    if [ -z "$ODOO_DB_SUPERPASSWORD" ]; then
        echo "❌ Error: ODOO_DB_SUPERPASSWORD environment variable not set"
        return 1
    fi
    
    echo "📊 Odoo Databases on $ODOO_DB_HOST:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -c "
        SELECT 
            d.datname as \"Database\",
            pg_catalog.pg_get_userbyid(d.datdba) as \"Owner\",
            pg_size_pretty(pg_database_size(d.datname)) as \"Size\"
        FROM pg_catalog.pg_database d
        WHERE d.datistemplate = false
          AND d.datname NOT IN ('postgres', 'template0', 'template1')
        ORDER BY d.datname;
    " 2>/dev/null
}

# Function: drop_odoo_env
# Drops a database and its associated role
# Usage: drop_odoo_env <db_name>
# Example: drop_odoo_env odoo18
drop_odoo_env() {
    local db_name="$1"
    
    if [ -z "$db_name" ]; then
        echo "❌ Error: Database name required"
        echo "Usage: drop_odoo_env <db_name>"
        echo "Example: drop_odoo_env odoo18"
        return 1
    fi
    
    if [ -z "$ODOO_DB_SUPERPASSWORD" ]; then
        echo "❌ Error: ODOO_DB_SUPERPASSWORD environment variable not set"
        return 1
    fi
    
    echo "⚠️  WARNING: This will permanently delete database '$db_name'"
    read -p "Are you sure? (yes/no): " confirm
    
    if [ "$confirm" != "yes" ]; then
        echo "❌ Cancelled"
        return 0
    fi
    
    echo "🗑️  Dropping database: $db_name"
    PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -c "DROP DATABASE IF EXISTS \"$db_name\";" 2>/dev/null
    
    echo "🗑️  Dropping role: $db_name"
    PGPASSWORD="$ODOO_DB_SUPERPASSWORD" psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_SUPERUSER" -c "DROP ROLE IF EXISTS \"$db_name\";" 2>/dev/null
    
    echo "✅ Dropped DB/User = $db_name"
}

echo "✅ Odoo database tools loaded (mkdb, envdb, listdb, dropdb)"

#!/bin/bash

# Script to update exercise data for allen, john_doe, and david_wilson
# Adds October 1-7 data and recent 7 days (Nov 26-Dec 2)

echo "=========================================="
echo "Exercise Data Update Script"
echo "=========================================="
echo ""
echo "This will update exercise data for:"
echo "  - allen (user_id=24)"
echo "  - john_doe (user_id=4)"
echo "  - david_wilson (user_id=8)"
echo ""
echo "Adding data for:"
echo "  - October 1-7, 2025 (7 days)"
echo "  - November 26 - December 2, 2025 (7 days)"
echo ""

# Check if MySQL is accessible
if ! command -v mysql &> /dev/null; then
    echo "Error: MySQL client not found. Please install MySQL."
    exit 1
fi

# Default database settings
DB_NAME="exercise_tracker"
DB_USER="root"

# Prompt for password
echo "Enter MySQL password for user '$DB_USER':"
read -s DB_PASS

echo ""
echo "Updating exercise data..."

# Execute the SQL file
mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < update-exercise-data.sql

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✓ Exercise data updated successfully!"
    echo "=========================================="
    echo ""
    echo "Summary:"
    echo "  - Allen: 28 new exercise records"
    echo "  - John Doe: 28 new exercise records"
    echo "  - David Wilson: 28 new exercise records"
    echo "  - Total: 84 new exercise records"
    echo ""
else
    echo ""
    echo "=========================================="
    echo "✗ Error updating exercise data"
    echo "=========================================="
    exit 1
fi

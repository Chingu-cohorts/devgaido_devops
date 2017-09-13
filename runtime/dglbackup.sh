#!/bin/bash

#------------------------------------------------------------------------------
# Script:  dglbackup.sh
# Purpose: Create a "hot" backup of the devGaido Mongo database on the local
#          application server.
#          1. Verify that the devGaido backend is up and running
#          2. Check for the presence of the /dglbackups directory and create
#             if its not found.
#          2. Run mongodump -o ../dglbackups to create a backup
#------------------------------------------------------------------------------

echo "Starting devGaido 'hot' backup..."

echo "...Verifying that MongoDB instance is available..."
# Try to display Mongo statistics to check if the instance is running.
# '$?. will be 0 if the command succeeds.
echo "Verifying that MongoDB is running" > ./dgllog.txt
mongo --eval "db.stats()" >> ./dgllog.txt
RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo "......MongoDB is not running. Please start before attempting backup"
    echo "Aborting backup. MongoDB not running" >> ./dgllog.txt
    exit 1
fi

echo "...Backing up devGaido database..."
# Create the local backup directory if it does not exist
# [ ! -d ./dglbackups ] && mkdir -p ./dglbackups
if test ! -d ./dglbackups
then
    echo "......Creating local backup directory ./dglbackups"
    mkdir -p ./dglbackups
    echo "Create missing backup directory" >> ./dgllog.txt
fi

mongodump -o ./dglbackups >> ./dgllog.txt
RESULT=$?
if [ $RESULT = 0 ]; then
  echo "Backup successfully completed. Return code=" $RESULT
  echo "Backup successfully completed. Return code=" $RESULT >> ./dgllog.txt
else
  echo "Backup was unsuccessful. Return code=" $RESULT
  echo "Backup was unsuccessful. Return code=" $RESULT >> ./dgllog.txt
fi

echo "Ending devGaido 'hot' backup"
exit 0
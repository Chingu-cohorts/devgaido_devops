#!/bin/bash

# Common Bash functions
source dglog.sh

#==============================================================================
# Script:  dglbackup.sh
# Purpose: Create a "hot" backup of the devGaido Mongo database on the local
#          application server. 
#
# TODO: only backup catalog and devGaido
# TODO: use 'docker exec -it <CONTAINER_NAME> /bin/bash' to execute in a 
#       container. 
# TODO: Look at container-to-container communication. E.g. have automation
#       container fire this script from within the Mongo container. Look at 
#       pid to share processes between containers --> 
#          https://www.guidodiepen.nl/2017/04/accessing-container-contents-from-another-container/
#==============================================================================

#------------------------------------------------------------------------------
# Mainline Script Logic 
#------------------------------------------------------------------------------ 

initlog "./dgllog.txt"
log "...Verifying that MongoDB instance is available..."
# Try to display Mongo statistics to check if the instance is running.
# '$?'. will be 0 if the command succeeds.
log "Verifying that MongoDB is running" both
mongo --eval "db.stats()" >> $LOGFILE
RESULT=$?
if [ $RESULT -ne 0 ]; then
    log "...Aborting backup. MongoDB not running" both
    exit 1
fi

log "...Backing up devGaido database..."
# Create the local backup directory if it does not exist
# [ ! -d ./dglbackups ] && mkdir -p ./dglbackups
if test ! -d ./dglbackups
then
    log "......Creating local backup directory ./dglbackups" both
    mkdir -p ./dglbackups
    log "Create missing backup directory" log
fi

mongodump -o ./dglbackups >> ./dgllog.txt
RESULT=$?
if [ $RESULT = 0 ]; then
  log "Backup successfully completed. Return code=$RESULT" both
else
  log "Backup was unsuccessful. Return code=$RESULT" both
fi

log "Ending devGaido 'hot' backup" both
exit 0
#!/bin/bash

# Common Bash functions
source ./dglog.sh

#==============================================================================
# Script:  dglbackup.sh
# Purpose: Create a "hot" backup of the devGaido Mongo database on the local
#          application server. 
#
# TODO: use 'docker exec -it <CONTAINER_NAME> /bin/bash' to execute in a 
#       container. 
# TODO: Look at container-to-container communication. E.g. have automation
#       container fire this script from within the Mongo container. Look at 
#       pid to share processes between containers --> 
#          https://www.guidodiepen.nl/2017/04/accessing-container-contents-from-another-container/
#==============================================================================

LOGFILE="./dgllog.txt"

#------------------------------------------------------------------------------
# Mainline Script Logic 
#------------------------------------------------------------------------------ 

TIMEFORMAT="Elapsed time=%lR - User Mode CPU time=%lU - System Mode CPU time=%lS" 
time {
  initlog "$LOGFILE" "Starting devGaido Hot Backup..."

  # Try to display Mongo statistics to check if the instance is running.
  # '$?'. will be 0 if the command succeeds.
  log $LOGFILE "...Verifying that MongoDB instance is running..." both
  mongo --eval "db.stats()" >> $LOGFILE
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
      log $LOGFILE "...Aborting backup. MongoDB not running" both
      exit 1
  fi

  log $LOGFILE "...Backing up admin & devGaido databases..."
  # Create the local backup directory if it does not exist
  # [ ! -d ./dglbackups ] && mkdir -p ./dglbackups
  if test ! -d ./dglbackups
  then
      log $LOGFILE "......Creating local backup directory ./dglbackups" both
      mkdir -p ./dglbackups
      log $LOGFILE "...Create missing backup directory" log
  fi

  mongodump --verbose --db admin -o ./dglbackups 2>> $LOGFILE
  RESULT=$?
  if [ $RESULT = 0 ]; then
    log $LOGFILE "...Backup of admin db successfully completed. Return code=$RESULT" both
  else
    log $LOGFILE "...Backup of admin db was unsuccessful. Return code=$RESULT" both
  fi

  mongodump --verbose --db devgaido -o ./dglbackups 2>> $LOGFILE
  RESULT=$?
  if [ $RESULT = 0 ]; then
    log $LOGFILE "...Backup of devgaido db successfully completed. Return code=$RESULT" both
  else
    log $LOGFILE "...Backup of devgaido db was unsuccessful. Return code=$RESULT" both
  fi

  log $LOGFILE "Ending devGaido 'hot' backup" both
}
exit 0
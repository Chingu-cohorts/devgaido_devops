#!/bin/bash

#------------------------------------------------------------------------------ 
# Function: initlog
# Purpose:  Initialize the disk log file the log function will be adding 
#           entries to
# Usage:    initlog <log-file-name>
#------------------------------------------------------------------------------ 
initlog () {
  LOGFILE=$1
  if [ "${LOGFILE:-0}" == 0 ]; then
    echo "Aborting: Log file name omitted. LOGFILE="$LOGFILE
  fi
  echo "" > $LOGFILE
}

#------------------------------------------------------------------------------ 
# Function: log
# Purpose:  Write and informational message to the console and/or log file
# Usage:    log <message> <target>
#             where: 
#                <message> - Informational text to be written
#                <target>  - Defines where the text is to be written to
#                            'log'     - write only to the log file
#                            'console' - write only to the console
#                            'both'    - write to both the log file AND console
#             
#------------------------------------------------------------------------------
log () {
  MESSAGE=$1
  TARGET=${2:-console}
  if [ "${MESSAGE:-0}" == 0 ]; then
    echo "Aborting! Log message omitted. MESSAGE="$MESSAGE
    exit 1
  fi

  case "$TARGET" in
    "console")
      echo "$MESSAGE"
      ;;
    "log")
      echo "$MESSAGE">>$LOGFILE
      ;;
    "both")
      echo "$MESSAGE"
      echo "$MESSAGE">>$LOGFILE
      ;;
    *)
      echo "Aborting! Invalid target specified. TARGET="$TARGET
  esac
}
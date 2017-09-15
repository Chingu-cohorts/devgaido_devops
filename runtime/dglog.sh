#!/bin/bash

#------------------------------------------------------------------------------ 
# Function: currentTS
# Purpose:  Generate a timestamp for the current time
# Usage:    currentTS
#------------------------------------------------------------------------------ 
currentTS () {
  TS=`date "+%Y-%m-%dT%H:%M:%S"`
  echo $TS
}

#------------------------------------------------------------------------------ 
# Function: initlog
# Purpose:  Initialize the disk log file the log function will be adding 
#           entries to
# Usage:    initlog <log-file-name> <init-message>
#           where:
#             <log-file-name> - Path and file name of the log file
#             <init-message>  - Initialization message to be added to first
#                               line of the log file
#------------------------------------------------------------------------------ 
initlog () {
  LOGFILE=$1
  INITMSG=$2
  if [ "${LOGFILE:-0}" == 0 ]; then
    echo "Aborting: Log file name omitted. LOGFILE="$LOGFILE
  fi
  
  TS=$(currentTS)
  echo "$TS: $INITMSG" > $LOGFILE
}

#------------------------------------------------------------------------------ 
# Function: log
# Purpose:  Write and informational message to the console and/or log file
# Usage:    log <log-file-name> <message> <target>
#           where: 
#             <log-file-name> - path and file name of the log file. The log
#                               file must have been previously created with 
#                               initlog.
#             <message>       - Informational text to be written
#             <target>        - Defines where the text is to be written to
#                               'log'     - write only to the log file
#                               'console' - write only to the console
#                               'both'    - write to both the log file AND 
#                                           the console
#------------------------------------------------------------------------------
log () {
  LOGFILE=$1
  MESSAGE=$2
  TARGET=${3:-console}
  if [ "${LOGFILE:-0}" == 0 ]; then
    echo "$$TS: Aborting! Log file name omitted. LOGFILE="$LOGFILE
  fi
  if [ "${MESSAGE:-0}" == 0 ]; then
    echo "$TS: Aborting! Log message omitted. MESSAGE="$MESSAGE
    exit 1
  fi

  TS=$(currentTS)
  case "$TARGET" in
    "console")
      echo "$TS: $MESSAGE"
      ;;
    "log")
      echo "$TS: $MESSAGE">>$LOGFILE
      ;;
    "both")
      echo "$TS: $MESSAGE"
      echo "$TS: $MESSAGE">>$LOGFILE
      ;;
    *)
      echo "$TS: Aborting! Invalid target specified. TARGET="$TARGET
  esac
}

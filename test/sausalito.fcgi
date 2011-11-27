#!/bin/bash

# Copyright 2010 28msec Inc.

PROGRAM="/opt/sausalito/bin/sausa_fcgi"

export LD_LIBRARY_PATH="/opt/sausalito/lib"
export SAUSALITO_HOME="/opt/sausalito"
export SAUSALITO_PROJECT_PHYSICAL_URI="/home/guof/flickrVision"
export SAUSALITO_PROJECT_LOGICAL_URI="http://www.example.com/flickrVision/"
export SAUSALITO_LOG_PATH="/home/guof/flickrVision/test/log"
export SAUSALITO_PROPERTY_FILE="/home/guof/flickrVision/.config/sausalito.props"
export SAUSALITO_TEMP="/tmp"
export SAUSALITO_DEBUG=""
export SAUSALITO_PORTS="8028:9028"
export SAUSALITO_XML_INDENT="true"
export SAUSALITO_REQUEST_AUDIT=""
export SAUSALITO_AUDIT_PROVIDER=""
export SAUSALITO_DEBUG_SLEEP=""
export LANG="en_US.UTF-8"
export SAUSALITO_REQUEST_URI
 
if test -f "$PROGRAM"
then
  exec "$PROGRAM"
else
  # The program doesn't exist.
  $echo "$0: error: $PROGRAM does not exist" 1>&2
  exit 1
fi

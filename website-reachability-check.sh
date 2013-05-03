#!/bin/bash

# Website Reachability Check Shell Script
#
# Shell script to check the reachability of a website.
# It executes a ping and traceroute which helps to determine
# whether it's a network issue.
# It verifies the status code in the response header of the website.
#
# The script depends on:
#   ping
#   traceroute
#   curl
#
#
#    Copyright (C) 2013 Andreas Dangel <adangel at users.sourceforge.net>
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

WEBSITES='
google__80 http://www.google.de:80/index.html
google_443 https://www.google.de:443/
'


IFS='
'

function prefix()
{
    NAME=$1
    DATA=$2
    TEXT="$NAME: $3"
    for d in $DATA; do
        TEXT="${TEXT}
$NAME:   $d"
    done
    echo "$TEXT"
}

for i in $WEBSITES; do
    DATE=`LANG=en_US.utf8 date`
    NAME=${i/ */}
    HOSTNAME=${i/* /}
    PROTOCOL=${HOSTNAME/:\/\/*/}
    HOSTNAME=${HOSTNAME/http:\/\//}
    HOSTNAME=${HOSTNAME/https:\/\//}
    PORT=${HOSTNAME/*:/}
    URI_PATH=${PORT/*\//}
    PORT=${PORT/\/*/}
    HOSTNAME=${HOSTNAME/:*/}
    
    PING=`ping -c 4 $HOSTNAME`
    PINGTEXT=$(prefix $NAME "$PING" "Ping to $HOSTNAME:")
    TRACE=`traceroute $HOSTNAME`
    TRACETEXT=$(prefix $NAME "$TRACE" "Traceroute to $HOSTNAME:")

    REQUEST="${PROTOCOL}://${HOSTNAME}:${PORT}/${URI_PATH}"
    CURL=`curl -I $REQUEST 2>/dev/null`
    if [ $? != 0 ]; then
        CURLERROR=`curl -I $REQUEST 2>&1`
    fi
    CURLTEXT=$(prefix $NAME "$CURL" "HTTP Header for $REQUEST:")
    `echo $CURL | grep "HTTP/1\.. 200" >/dev/null 2>&1`
    if [ $? = 0 ]; then
        STATUS="$NAME: Test PASSED."
    else
        STATUS="$NAME: Test FAILED."
        if [ "$CURLERROR" != "" ]; then
            STATUS=$(prefix $NAME "$CURLERROR" "Test FAILED. Curl error output for $REQUEST:")
        fi
    fi
    
    echo "$NAME: "
    echo "$NAME: $DATE"
    echo "$NAME: Host    : $HOSTNAME"
    echo "$NAME: Port    : $PORT"
    echo "$NAME: Prot    : $PROTOCOL"
    echo "$NAME: Path    : $URI_PATH"
    echo "$PINGTEXT"
    echo "$TRACETEXT"
    echo "$CURLTEXT"
    echo "$STATUS"
    echo
done


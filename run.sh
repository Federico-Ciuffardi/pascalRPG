#!/bin/bash
source <(/usr/bin/resize -s)
/usr/bin/resize -s 24 104
./pascalRPG
/usr/bin/resize -s $LINES $COLUMNS

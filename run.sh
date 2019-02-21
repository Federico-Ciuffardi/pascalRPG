#!/bin/bash
source <(/usr/bin/resize -s)
/usr/bin/resize -s 35 104
./pascalRPG
/usr/bin/resize -s $LINES $COLUMNS

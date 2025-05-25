#!/bin/bash

# Get day, English month, and weekday number
DAY=$(date '+%d')
MONTH=$(date '+%B')
WDAY_NUM=$(date +%w)

# Marathi weekday names
DAYS=("रविवार" "सोमवार" "मंगळवार" "बुधवार" "गुरूवार" "शुक्रवार" "शनिवार")

# Get Marathi day
MARATHI_DAY=${DAYS[$WDAY_NUM]}

# Final Output
echo "$DAY $MONTH $MARATHI_DAY"

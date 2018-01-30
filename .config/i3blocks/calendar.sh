#!/bin/sh

# blockdate=

echo $(date '+%H:%M')

case "$BLOCK_BUTTON" in
    1|2|3) 
    gsimplecal
esac

# date '+%d.%m.%Y'
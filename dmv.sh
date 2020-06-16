#!/usr/bin/env bash

# replace the value of COOKIE with the actual Session ID found in the web browser. See README.md
COOKIE="ASP.NET_SessionId"

START_DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%Y)

i=0
while
    RELEASED=0
    CHECK_BACK=0
    AVAILABLE=0

    DAY="$((START_DAY+i))"
    #echo "date ${MONTH}/${DAY}/${YEAR}"
    : ${start=$i}              # capture the starting value of i

    URL="https://ridmvreservations.stonewallsolutions.com/Reservation/GetCalendarTimeSlots?SelectedDate=${MONTH}%2F${DAY}%2F${YEAR}"

    echo "running http ${URL} Cookie:ASP.NET_SessionId=${COOKIE}"
    RESPONSE=$(http ${URL} Cookie:ASP.NET_SessionId=${COOKIE})

    echo $RESPONSE  | grep -q "Reservations for the visit type you have requested have not been released for this day yet, please check back on a later date"
    RELEASED=$?
#    echo $RELEASED

    echo $RESPONSE | grep -q "No reservations are currently available, please check back at a later time" -
    CHECK_BACK=$?
#    echo $CHECK_BACK

    echo $RESPONSE | grep -q "No reservation(s) available" -
    AVAILABLE=$?
#    echo $AVAILABLE

    if [ "$RELEASED" = "1" ] && [ "$CHECK_BACK" = "1" ] && [ "$AVAILABLE" = "1" ]; then
        tput bel
        echo "Date found!"
        echo ${URL}
        tput bel
        echo $RESPONSE
    fi

    i="$((i+1))"               # increment the variable of the loop.
    [ "$i" -lt 16 ]
do :; done
#echo "Final value of $i///$start"
#echo "The loop was executed $(( i - start )) times "

---
ridmv-reservations
---

# Get alerted when new reservation slots open for the RI DMV

This script will alert when a reservation slot opens up for the RI DMV. It is for people who want to make
a reservation to conduct business at the RI DMV.

RI DMV has instituted a reservation system for all transactions.  Reservations are hard to come by and
the reservation system does not provide a feature to alert people of new reservations, like a callback or a queue.

Citizens wishing to do business with the RI DMV must wait by a computer and manually refresh the reservation
page in a browser.

This script will check the reservation page for you and beep when a slot has opened up. You do not need to sit
and wait at a computer, hoping a reservation will open up.
You then need to visit the reservation system and make your reservation.

## Use cases

When I used this script I set it running every minute at about 6:30 PM.  At approximately 10:00 PM, three
and a half hours later, I was alerted to an opening.  That was three hours I spent doing other things that were
more productive.

## Requirements

* bash
* [httpie](https://httpie.org/)
* Advanced knowledge of web browsers

## Instructions

1. Clone this repository or download the script dmv.sh.
1. Visit the [RI DMV Reservation System](https://ridmvreservations.stonewallsolutions.com/Reservation/CalendarTimeSlots)
1. Follow the steps to create a reservation.
1. Use the web browser's developer mode to obtain the value of the cookie named *ASP.NET_SessionID*
1. Edit the script and update the variable *COOKIE* to the valiue of *ASP.NET_SessionID*
1. Run the script on an infinite loop in a bash terminal.

### Example

Note, the *sleep* command here is important. Do not spam the RI DMV Reservation System, you'll probably get blocked.

```shell
while ; do ./dmv.sh; sleep 60; done
```

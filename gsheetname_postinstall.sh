#!/bin/sh
## postinstall

# Long Google Sheet ID taken from the url of the sheet
# Like for 
# https://docs.google.com/spreadsheets/d/1-_KZMQ_xK1T9jenzEbElefxKFjZD08TrEyQQw3j5YaQ/edit#gid=0
# The sheet id is   1-_KZMQ_xK1T9jenzEbElefxKFjZD08TrEyQQw3j5YaQ
# The Google Sheet needs to be readable like Anyone One with Link Can View
# Replace _ with the id of the Google sheet you have created
sheetID="_"


# The column with the serial number in it
serialCol="A"
# The column with the device name in it.  Note we use column C so that a CSV file downloaded
# from Apple School/Business Manager can be imported/appended as new devices are purchased
# The ASM/ABM CSV uses column A for serial number and column B for device type
nameCol="C"

# get the device serial number
serialNumber=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

# Look up serial number from Google Sheet using the Google Visualization api returning simple csv
dname=$(curl --silent "https://docs.google.com/spreadsheets/d/$sheetID/gviz/tq?tqx=out:csv&tq=%20select%20$nameCol%20WHERE%20$serialCol%3D%27$serialNumber%27")

# Remove the header information and quotes
dname=$(echo $dname | cut -d '"' -f 2)

#Test to see if no value is returned and use serial number instead
if test -z $dname ; then
  dname=$serialNumber
fi

# If a device naming convention is used, consider adding code here to test for conformation

# For testing. Comment out for production
echo $dname

# Name the device using best value
# Uncomment these 4 lines to actually name the device, commented for safety
# scutil --set LocalHostName "$dname"
# scutil --set ComputerName "$dname"
# scutil --set HostName  "$dname"
# dscacheutil -flushcache

exit 0		## Success
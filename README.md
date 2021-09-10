# gsheetnamer
Shell Script to read macOS device serial number and return a device name - Intended for PostInstall script in PKG installer

Uses the Google Visualization API to make an SQL-like query to a readable Google Sheet and return a string then rename the macOS device with that string.  If the GSheet query errors out then the device will end up with a garbage or possibly redundant name.  There is no 100% way to verify the return string is "good" since names are arbitrary.  If your naming convention is uniform consider adding a test to confirm or fall back to serial number alone.

Note column C in the Google Sheet is used to store the device name so that a CSV file downloaded from Apple School/Business Manager can be imported/appended as new devices are purchased The ASM/ABM CSV uses column A for serial number and column B for device type.
In ASM/ABM use the Order Number as search criteria to download a list of new devices purchased. Then use the Append to Sheet import function in Google Sheets.  
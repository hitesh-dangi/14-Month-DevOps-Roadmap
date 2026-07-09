#/bin/bash

# One lin command using grep and awk that filter for the error lines and print only the IP address

grep -F "[ERROR]" /home/hitesh/practice/access.log | awk '{print $1}' > IP_address.txt

echo "Log file checked and the suspected IP address are redirected to the IP_address.txt file....."

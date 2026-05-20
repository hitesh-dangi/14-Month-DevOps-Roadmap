#!/bin/bash

# 1. Asking the user for details
echo "Enter your age: "
read Age
echo "Do you have a license(Yes or No): "
read License

# 2. Converting license to lowercase
License=${License,,}

# 3. Eligiblity check
if [[ "$Age" -ge 18 && "$License" == "yes" ]]; then
	echo "You are eligible to drive the server van."
else
	echo "Access denied! Requirements not meet."
fi

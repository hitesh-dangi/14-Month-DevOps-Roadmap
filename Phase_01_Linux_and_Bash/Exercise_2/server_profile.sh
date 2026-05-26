#!/bin/bash

# 1. Asking user for details
echo "User Name: "
read UserName
echo "User Employee Id: "
read EmployeeID
echo "Network Port Number: "
read PortNo

# 2. Output report
echo "=============================="
echo "New Server Profile Generated"
echo "=============================="
echo "Deployer: [$UserName]"
echo "ID Tag:   [$EmployeeID]"
echo "Config:   Traffic allowed on Port : [$PortNo]"
echo "=============================="

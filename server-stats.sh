#!/bin/bash

###########################
# Author: Jacob Akotuah
#
# This script analyses basic server performance stats
#
# Version: v1.1
###########################

# Function to print a header
print_header() {
  echo -e "\n=============================="
  echo -e "$1"
  echo -e "=============================="
}

# CPU Usage
print_header "CPU Usage"
top -bn1 | grep "Cpu(s)" | \
  awk '{print "CPU Usage: " 100 - $8 "% used"}'

# Memory Usage
print_header "Memory Usage"
free -b | awk 'NR==2{printf "Memory Usage: %.2f Gi/%.2f Gi (%.2f%% used)\n", $3/1073741824, $2/1073741824, $3*100/$2 }'

# Disk Usage
print_header "Disk Usage"
df -h --total | awk 'END{printf "Disk Usage: %s/%s (%.2f%% used)\n", $3,$2,$5}'

# Top 5 processes by CPU usage
print_header "Top 5 Processes by CPU Usage"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
print_header "Top 5 Processes by Memory Usage"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Additional Stats
print_header "Additional Stats"
# OS Version
echo -e "OS Version: $(lsb_release -d | cut -f2)"

# Uptime
echo -e "Uptime: $(uptime -p)"

# Load Average
echo -e "Load Average: $(uptime | awk -F'load average: ' '{print $2}')"

# Logged in Users
echo -e "Logged in Users: $(who | wc -l)"

# Failed Login Attempts
echo -e "Failed Login Attempts: $(grep 'Failed password' /var/log/auth.log | wc -l)"

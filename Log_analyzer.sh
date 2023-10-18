#!/bin/bash

# Set the directory where your log files are located
log_directory="/Users/Shriram/Desktop/Test_Log"

# Set today's date in the format YYYY-MM-DD
today_date=$(date +%Y-%m-%d)

# Create a report file
report_file="Log_report_$today_date.txt"

# Add email header lines to the report
echo "To: shrirampiyerthepatriot@gmail.com, shrirampiyerpilot@gmail.com" > "$report_file"
echo "Subject: Log status: $today_date" >> "$report_file"
echo "" >> "$report_file"

# Loop through log files in the directory generated today
for log_file in "$log_directory"/*.{log,txt}; do
    if [[ -f "$log_file" ]]; then
        # Get the file's modification date in the YYYY-MM-DD format
        file_date=$(date -r "$log_file" +%Y-%m-%d)
        
        # Check if the log file was generated today
        if [ "$file_date" = "$today_date" ]; then
            # Check if the log file contains errors (you can adjust this condition)
            if grep -q "error" "$log_file"; then
                echo "Filename: $log_file - Error found" >> "$report_file"
            else
                echo "Filename: $log_file - Error free" >> "$report_file"
            fi
        fi
    fi
done

msmtp --read-recipients < $report_file
echo "Report generated: $report_file"

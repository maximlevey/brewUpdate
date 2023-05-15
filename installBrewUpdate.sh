#!/bin/bash
# .-.-.-..---..-..-..-..-.-.-.
# | | | || | | > < | || | | |
# `-'-'-'`-^-''-'`-``-'`-'-'-'

#==============================
#	Information
#==============================

# installBrewUpdate.sh
# Install and configure brewUpdate
# Created by Maxim Levey <github.com/maximlevey>
# Last Modified 15/05/2023

#==============================
#	Variables
#==============================

logDirectory=~/Library/Logs/brewUpdate
logFile="$(date +%d-%m-%Y).log"
brewUpdateDirectory=~/Library/brewUpdate
homeFolder=$(whoami)

#==============================
#	Functions
#==============================

# Create logging function
function log() {
	echo -e "$(date "+[%H:%M:%S]") ${1}" | tee -a "$logDirectory/$logFile"
}

# Create decaf function	
# Function kills CAFPID (Caffeinate Process ID) if running
function decaf () {
	
	if [ ${CAFPID} ]; then
		/bin/echo "Decaffeinated"
		kill ${CAFPID}
	fi
}

#==============================
#	Start Script
#==============================

# Execute decaf function upon script exit
trap decaf EXIT

# Create log file
if [ ! -d "$logDirectory" ]; then
	mkdir -p "$logDirectory"
fi
touch "$logDirectory/$logFile"

# Check if device already Caffeinated, caffeinate if not
if /bin/ps auxww | grep -q "[c]affeinate"; then
	/bin/echo "Already caffeinated"
else
	/bin/echo "Caffeinating..."
	/usr/bin/caffeinate -dimsu &
	CAFPID=$!
fi

# Prompt the user to set updateFrequency
read -p "How often would you like to run brewUpdate? Please enter in hours" hours

updateFrequency=$((hours*3600))

echo "Setting up brewUpdate..."
log "Setting up brewUpdate..."

#-----------------------------
#   Setup brewUpdate
#-----------------------------

echo "Creating a directory at $brewUpdateDirectory"

# Create a directory for brewUpdate
if [ ! -d "$brewUpdateDirectory" ]; then
	mkdir -p "$brewUpdateDirectory"
fi

# Move the brewUpdate script to that directory
mv brewUpdate.sh "$brewUpdateDirectory"

# Move the brewUpdate script to that directory
chmod +x "$brewUpdateDirectory/brewUpdate.sh"

# Write the brewUpdate Launch Agent
cat <<EOF > "/Users/$homeFolder/Library/LaunchAgents/brewUpdate.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>Label</key>
		<string>com.maximlevey.brewUpdate</string>
		<key>ProgramArguments</key>
		<array>
			<string>/bin/bash</string>
			<string>/Users/$homeFolder/Library/brewUpdate/brewUpdate.sh</string>
		</array>
		<key>StartInterval</key>
		<integer>$updateFrequency</integer> 
		<key>RunAtLoad</key>
		<true/>
	</dict>
</plist>
EOF

echo "Starting the Launch Agent"

#-----------------------------
#   Start Launch Agent
#-----------------------------

# Start the brewUpdate launch agent
launchctl load -w "/Users/$homeFolder/Library/LaunchAgents/brewUpdate.plist"

# Check if the launch agent is running
if launchctl list | grep -Fq "com.maximlevey.brewUpdate"; then
	log "brewUpdate launch agent is running"
else
	echo "Failed to start brewUpdate launch agent, must be started manually"
	echo "See github.com/maximlevey/brewUpdate for instructions"
fi

echo "brewUpdate Setup Complete"
log "brewUpdate Setup Complete"
echo "brewUpdate will run every $hours hours"

exit 0

#==============================
#	End Script
#==============================

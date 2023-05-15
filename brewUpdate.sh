#!/bin/bash
# .-.-.-..---..-..-..-..-.-.-.
# | | | || | | > < | || | | |
# `-'-'-'`-^-''-'`-``-'`-'-'-'

#==============================
#	Information
#==============================

# updateBrew.sh
# Call on Brew to Update, Upgrade and Cleanup packages
# Created by Maxim Levey <github.com/maximlevey>
# Last Modified 04/05/2023

#==============================
#	Variables
#==============================

logDirectory=~/Library/Logs/brewUpdate
logFile="$(date +%d-%m-%Y).log"

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

# Create log file if not already present
if [ ! -d "$logDirectory" ]; then
	mkdir -p "$logDirectory"
fi
touch "$logDirectory/$logFile"

log "brewUpdate starting..."
log ""

# Check if device already Caffeinated, caffeinate if not
if /bin/ps auxww | grep -q "[c]affeinate"; then
	/bin/echo "Already caffeinated"
else
	/bin/echo "Caffeinating..."
	/usr/bin/caffeinate -dimsu &
	CAFPID=$!
fi

# Run Brew Update
# Fetch the newest version of Homebrew and all formulae from GitHub
log "Running brew update"
/opt/homebrew/bin/brew update > >(while IFS= read -r line; do log "$line"; done)

# Run Brew Upgrade
# Upgrade outdated casks and outdated, unpinned formulae
log "Running brew upgrade"
/opt/homebrew/bin/brew upgrade > >(while IFS= read -r line; do log "$line"; done)

# Run Brew Cleanup
# Remove stale lock files and outdated downloads for all formulae and casks
log "Running brew cleanup"
/opt/homebrew/bin/brew cleanup > >(while IFS= read -r line; do log "$line"; done)

# Delete logs older than 30 days
find "$logDirectory" -type f -name "*.log" -mtime +30 -exec rm {} \;

log ""
log "brewUpdate complete!"
log "Exiting..."

exit 0

#==============================
#	End Script
#==============================

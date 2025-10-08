#!/usr/bin/env bash

# Send a notification with an action
id=$(notify-send "Update Available" \
    "Do you want to install now?" \
    --action=default="Install" \
    --action=cancel="Cancel" \
    --print-id)

echo "Notification ID: $id"

# Listen for action responses
dbus-monitor "interface='org.freedesktop.Notifications',member='ActionInvoked'" |
while read -r line; do
    if echo "$line" | grep -q "$id"; then
        if echo "$line" | grep -q "default"; then
            echo "You chose: Install"
            # put your install command here
        elif echo "$line" | grep -q "cancel"; then
            echo "You chose: Cancel"
            # handle cancel
        fi
        break
    fi
done

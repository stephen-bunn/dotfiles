#!/usr/bin/env sh

DEPENDENCIES="dmenu bw jq xclip";
for dep_name in $DEPENDENCIES
do
    if !(command -v "$dep_name" > /dev/null 2>&1); then
        echo "$dep_name not found";
        exit 1;
    fi
done

SESSION_FILE=/tmp/dmenu_bw.session;

# handle establishing a session ID and persisting it to some temporary store
establish_session() {
    master=$(echo "" | dmenu -p "Bitwarden Master Password" -P);
    if [ -z $master ]; then
        exit 1;
    fi

    session=$(bw unlock "$master" --raw 2>&1);
    if [ "$session" = 'Invalid master password.' ]; then
        notify-send -u critical -h STRING:synchronous:dmenu_bw -t 3000 -- 'Bitwarden' 'Invalid Master Password';
        exit 1;
    fi
    echo "$session" > $SESSION_FILE;
    notify-send -u low -h STRING:synchronous:dmenu_bw -t 3000 -- 'Bitwarden' "Saving session to $SESSION_FILE";
}

# if session is not persisted, try and establish it
if [ ! -s "$SESSION_FILE" ]; then
    establish_session;
fi

# extract and set the appropriate BW_SESSION from a temporary store
session=$(head -n 1 "$SESSION_FILE");
if [ "$(bw status --session "$session" 2>&1 | head -n 1)" = 'Session key is invalid.' ]; then
    establish_session;
    session=$(head -n 1 "$SESSION_FILE");
fi
export BW_SESSION="$session";

# fetch and construct the items to prompt the user with
items=$(bw list items | jq -r '.[] | .name + " (" + .login.username + ") [" + .id + "]"');

# prompt the user with items and extract the ID of the selected item
selected=$(echo "$items" | dmenu -r -p "Bitwarden");
if [ -z $selected ]; then
    exit 1;
fi

selected_name=$(echo "$selected" | sed -E 's/^(.*)\[.*$/\1/');
selected_id=$(echo "$selected" | sed -E 's/^.*\[(.*)\]$/\1/');

# prompt the user with fields and copy the desired field from the Bitwarden item
field=$(echo 'Username\nPassword\nTOTP' | dmenu -r -i -p "Bitwarden Field");
if [ -z $field ]; then
    exit 1;
fi

content=$(bw get $(echo "$field" | tr '[A-Z]' '[a-z]') "$selected_id");
if [ -z "$content" ]; then
    notify-send -u critical -h STRING:synchronous:dmenu_bw -t 3000 -- 'Bitwarden' "No $field defined for $selected_name";
    exit 1;
fi

# copy and notify that some content was copied to the clipboard
echo "$content" | xclip;
notify-send -h STRING:synchronous:dmenu_bw -t 3000 -- "Bitwarden" "Copied $field for $selected_name";

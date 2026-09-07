#!/bin/bash

#!/bin/bash

# Check if wf-recorder is running; if so, stop it to save the recording
if pkill -SIGINT wf-recorder; then
    exit 0
fi

mkdir -p "$HOME/Videos"

# Automatically detect currently focused monitor
ACTIVE_MONITOR=$(hyprctl activeworkspace | grep -o 'on monitor [^:]*' | awk '{print $3}')

# Start recording via Radeon (VA-API) - VIDEO ONLY, NO AUDIO
wf-recorder -c hevc_vaapi -d /dev/dri/renderD128 -o "$ACTIVE_MONITOR" -f "$HOME/Videos/record_${ACTIVE_MONITOR}_$(date +%Y%m%d_%H%M%S).mp4"

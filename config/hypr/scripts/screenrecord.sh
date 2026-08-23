#!/bin/bash

#!/bin/bash

# Kiểm tra nếu wf-recorder đang chạy thì tắt để lưu file
if pkill -SIGINT wf-recorder; then
    exit 0
fi

# Tự động lấy tên màn hình đang focus
ACTIVE_MONITOR=$(hyprctl activeworkspace | grep -o 'on monitor [^:]*' | awk '{print $3}')

# Bắt đầu quay bằng Radeon (VA-API) - CHỈ QUAY HÌNH, KHÔNG THU ÂM
wf-recorder -c hevc_vaapi -d /dev/dri/renderD128 -o "$ACTIVE_MONITOR" -f "$HOME/Videos/record_${ACTIVE_MONITOR}_$(date +%Y%m%d_%H%M%S).mp4"

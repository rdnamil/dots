#!/bin/sh -e

if killall -SIGUSR1 gpu-screen-recorder ; then
    notify-send --hint=STRING:desktop-entry:'GPU Screen Recorder' --app-name "GPU Screen Recorder" -t 3000 -- "GPU Screen Recorder" "<div>
    Clipped!</div>"
else
    notify-send --hint=STRING:desktop-entry:'GPU Screen Recorder' --app-name "GPU Screen Recorder" -t 3000 -u low -- "GPU Screen Recorder" "<div>
    GPU Screen Recorder not running.</div>"
fi

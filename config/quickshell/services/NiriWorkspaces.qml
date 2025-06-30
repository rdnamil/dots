pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton { id: root
	property int numSpaces
	property int currentSpaces

	Process { id: workspaceNum
		running: true
		command: ["niri", "msg", "workspaces"]
		stdout: StdioCollector {
			onStreamFinished: {
				root.numSpaces = parseInt((text.trim().split('\n').pop()).match(/\d+/)?.[0], 10);
				root.currentSpaces = parseInt((text.split('\n').find(line => line.includes('*'))).match(/\d+/)?.[0], 10);
			}
		}
	}
	Timer {
		running: true
		repeat: true
		interval: 100
		onTriggered: workspaceNum.running = true
	}
}

/*---------------------------------
--- Quickshell config by andrel ---
---------------------------------*/

//@ pragma UseQApplication

import QtQuick
import Quickshell

ShellRoot {
	// editing the config starts here
	// bars and other items can be added here

	Bar {		// this is the default standard bar
		// properties for bars and widgets can be changed from here or
		// can be set globally from GlobalConfig.qml
		height: 26
		padding: 9
		spacing: 6

		// widgets are listed within one of the three columns
		leftItems: [
			Network {},
			Bluetooth {}
		]
		centreItems: [
			NiriWorkspaces { command: ["niri", "msg", "action", "toggle-overview"]; }
		]
		rightItems: [
			Tray {},
			Clock {
				format: "hh:mm"
			},
			Battery {
				spacing: 1
				fontSize:8
			}
		]
	}
	// rounded screen corners
	ScreenCorners {
		cornerRadius: 16
		corners: ["top-left", "top-right"]
	}
	// volume and brightness OSDs
	VolumeOSD {}
	BrightnessOSD {}
}

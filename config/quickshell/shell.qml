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
		height: 28
		padding: 18
		spacing: 8

		// widgets are listed within one of the three columns

		// left column
		// ---
		leftItems: [
			Network {},
			Bluetooth {},
			Player {}
		]

		// center column
		// ---
		centreItems: [
			NiriWorkspaces {
				command: ["niri", "msg", "action", "toggle-overview"]
				highlight { width: 12; height: 10; }
				notHighlight { width: 6; height: 6; }
			}
		]

		// right column
		// ---
		rightItems: [
			Tray { spacing: 2; },
			Clock {
				format: "dhh:mm"
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

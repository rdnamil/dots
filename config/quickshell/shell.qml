/*---------------------------------
--- Quickshell config by andrel ---
---------------------------------*/

//@ pragma UseQApplication

import QtQuick
import Quickshell
import "widgets"

ShellRoot {
	// editing the config starts here
	// bars and other items can be added here

	Bar {		// this is the default standard bar
		// properties for bars and widgets can be changed from here or
		// can be set globally from GlobalConfig.qml
		roundCorners: true

		// widgets are listed within one of the three columns

			// left column
			// ---
		leftItems: [
			Network {},
			Bluetooth {},
			PlayerMinimal {}
		]

			// center column
			// ---
		centreItems: [
			NiriWorkspaces { command: ["niri", "msg", "action", "toggle-overview"]; }
		]

			// right column
			// ---
		rightItems: [
			// Tray { spacing: 1; },
			Tray { menuMargins: 20; },
			Clock { dateFormat: "d"; timeFormat: "hh:mm"; },
			Battery {}
			// QuickCenter {}
		]
	}
	// rounded screen corners
	ScreenCorners { corners: ["top-left", "top-right"] }
	// volume and brightness OSDs
	OSDVolume {}
	OSDBrightness {}
}

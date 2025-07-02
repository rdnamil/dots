//@ pragma UseQApplication
import QtQuick
import Quickshell
import "widgets"

ShellRoot {
	Bar {
		// height: 34
		// radius: 9
		// padding: 10
		// spacing: 4
		colour: "black"

		leftItems: [
			Network {},
			Bluetooth {}
		]
		centreItems: [
			NiriWorkspaces {
				highlight:""
				notHighlight: ""
			}
		]
		rightItems: [
			Tray {
				// iconSize: 14
				symbol: "󰁒"
				// autoHide: false
			},
			Clock {
				format: "hh:mm"
			},
			Battery {
				spacing: 1
				fontSize: 9
			}
		]
	}
	VolumeOSD {}
	BrightnessOSD {}
}

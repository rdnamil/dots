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

		]
		rightItems: [
			Tray {
				// iconSize: 14
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
	// Border {
	// 	// radius: 9
	// }
}

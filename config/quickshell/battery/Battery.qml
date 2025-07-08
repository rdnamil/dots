pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton { id:root

	readonly property bool isCharging: (!UPower.onBattery)
	readonly property int percentage: UPower.displayDevice.percentage*100
	readonly property string health: {
		let level = "empty"
		if (root.percentage > 0 && root.percentage <= 14) {
			level = "caution"
		} else if (root.percentage >= 15 && root.percentage <= 59) {
			level = "low"
		} else if (root.percentage >= 60 && root.percentage <= 79) {
			level = "good"
		} else if (root.percentage >= 80 && root.percentage <= 99) {
			level = "full"
		} else if (root.percentage > 99) {
			level = "charged"
		}
	}

}

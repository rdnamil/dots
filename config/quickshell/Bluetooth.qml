/*---------------------------------
--- Bluetooth widget by andrel ---*
---------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:bluetooth"

Item { id: root
	property int iconSize: GlobalConfig.iconSize

	implicitWidth: icon.implicitWidth
	implicitHeight: icon.implicitHeight

	IconImage { id: icon
		readonly property string bluetoothState: {
			let bluState = "disabled"
			if (Bluetooth.powered) {
				if (!Bluetooth.devices.length) {
					bluState = "active"
				} else {
					bluState = "paired"
				}
			}
			return bluState;
		}
		source: "root:/icons/bluetooth/" + bluetoothState
		implicitSize: root.iconSize
	}
}

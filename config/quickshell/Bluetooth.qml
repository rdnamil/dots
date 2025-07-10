/*---------------------------------
--- Bluetooth widget by andrel ---*
---------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:"
import "root:bluetooth"

Item { id: root
	property int iconSize: GlobalConfig.iconSize

	implicitWidth: icon.implicitWidth
	implicitHeight: icon.implicitHeight

	IconImage { id: icon
		readonly property string bluetoothState: {
			let bluState = "disabled"
			if (Bluetooth.powered) {
				if (Bluetooth.paired) {
					bluState = "paired"
				} else {
					bluState = "active"
				}
			}
			return bluState;
		}
		source: "root:/bluetooth/icons/" + bluetoothState
		implicitSize: root.iconSize
	}
}

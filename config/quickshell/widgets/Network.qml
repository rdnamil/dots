import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:"
import "root:services"

Item { id: root
	implicitWidth: icon.implicitWidth
	implicitHeight: icon.implicitHeight

	IconImage { id: icon
		readonly property string networkType: {
			let netType = "disconnected"
			if (Network.active) {
				netType = "wireless"
			}
			return netType;
		}
		source: "root:/icons/network/" + networkType
		implicitSize: 16
	}
}

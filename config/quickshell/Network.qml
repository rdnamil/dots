/*-------------------------------
--- Network widget by andrel ---*
-------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:"
import "root:network"

Item { id: root
	property int iconSize: GlobalConfig.iconSize

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
		implicitSize: root.iconSize
	}
}

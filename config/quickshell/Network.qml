/*-------------------------------
--- Network widget by andrel ---*
-------------------------------*/

import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import "root:"
import "root:network"

Item { id: root
	property int iconSize: GlobalConfig.iconSize
	property string symColour: GlobalConfig.colour.foreground

	implicitWidth: icon.implicitWidth
	implicitHeight: icon.implicitHeight

	IconImage { id: icon
		// get the network type
		readonly property string networkType: {
			let type = "disconnected"
			if (ActiveNetwork.netType) {
				type = ActiveNetwork.netType
			}
			return type;
		}
		// get the signal strength if the connection is wireless
		readonly property int networkStrength: {
			let strength = 0
			if (networkType === 'wifi') {
				strength = Math.round(ActiveNetwork.netStrength /25) *25;	// round the signal strength to the nearest quarter
			}
			return strength;
		}
		source: "root:/network/icons/" + networkType + ((networkType === 'wifi') ? networkStrength : "")
		implicitSize: root.iconSize
	}

	// colour overlay symbolic icons
	ColorOverlay {
		anchors.fill: icon
		source: icon
		color: root.symColour
		visible: (networkType === 'wifi')
	}
}

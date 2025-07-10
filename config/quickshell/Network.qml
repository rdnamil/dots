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
	property bool symbolic: false
	property int iconSize: GlobalConfig.iconSize
	property string colour: GlobalConfig.colour.foreground
	property string fontFamily: GlobalConfig.font.mono
	property int fontSize: GlobalConfig.font.size

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

	implicitWidth: (root.symbolic) ? nerd.width : icon.width
	implicitHeight: (root.symbolic) ? nerd.height : icon.height

	IconImage { id: icon
		visible: !root.symbolic
		source: "root:/network/icons/" + root.networkType + ((root.networkType === 'wifi') ? root.networkStrength : "")
		implicitSize: root.iconSize
	}

	Text { id: nerd
		visible: root.symbolic
		text: {
			let symbol = "󰲛"
			if (root.networkType === 'ethernet') {
				symbol = "󰈀"
			} else if (root.networkType === 'wifi') {
				if (root.networkStrength === 0) {
					symbol = "󰤯"
				} else if (root.networkStrength === 25) {
					symbol = "󰤟"
				} else if (root.networkStrength === 50) {
					symbol = "󰤢"
				} else if (root.networkStrength === 75) {
					symbol = "󰤥"
				} else if (root.networkStrength === 100) {
					symbol = "󰤨"
				}
			}
			return symbol;
		}
		color: colour
		font { pointSize: fontSize; family: fontFamily; weight: fontWeight; }
	}

	// colour overlay symbolic icons
	ColorOverlay {
		anchors.fill: icon
		source: icon
		color: root.colour
		visible: (root.networkType === 'wifi') && !root.symbolic
	}
}

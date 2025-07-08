/*-------------------------------
--- Battery widget by andrel ---*
-------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:"
import "root:battery"

MouseArea { id: root
	property int spacing: GlobalConfig.spacing
	property string colour: GlobalConfig.colour.foreground
	property string fontFamily: GlobalConfig.font.sans
	property int fontSize: GlobalConfig.font.size

	implicitWidth: layout.width
	implicitHeight: layout.height

	Row { id: layout
		spacing: root.spacing

		Item {
			width: percentage.width
			height: icon.height

			Text { id: percentage
				height: icon.implicitSize
				verticalAlignment: Text.AlignVCenter
				text: Battery.percentage + "%"
				font.family: fontFamily
				font.pointSize: fontSize
				color: colour
			}
		}

		IconImage { id: icon
			source: {
				let icon = "root:/icons/battery/" + Battery.health
				if (Battery.isCharging == true) {
					icon = icon + "-charging"
				}
				return icon;
			}
			implicitSize: 16
		}
	}
}

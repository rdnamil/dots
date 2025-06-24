import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "root:"
import "root:services"

MouseArea { id: root
	property int spacing: Config.spacing
	property string colour: Config.colour.foreground
	property string fontFamily: Config.font.family
	property int fontSize: Config.font.size

	implicitWidth: layout.width
	implicitHeight: layout.height

	Row { id: layout
		spacing: root.spacing

		Text {
			text: Battery.percentage + "%"
			font.family: fontFamily
			font.pointSize: fontSize
			color: colour
		}

		IconImage {
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

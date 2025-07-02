import Quickshell.Services.SystemTray
import QtQuick
import "root:"
import "root:services"

Item { id: root
	property string colour: Config.colour.foreground
	property string fontFamily: Config.font.mono
	property int fontSize: Config.font.size
	property int iconSize: 14
	property int menuMargin: 17
	property string symbol: "<"
	property bool autoHide: true
	readonly property Repeater items: items

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

	Rectangle { id: background
		width: parent.width
		height: parent.height
		color: "black"

		MouseArea { id: hoverArea
			anchors.fill: parent
			hoverEnabled: true
		}

		Row { id: layout
			spacing: root.spacing

			Repeater { id: items
				model: SystemTray.items

				TrayItem {
					iconSize: root.iconSize
					menuMargin: root.menuMargin
				}
			}
		}

		Rectangle { id: hideContent
			visible: root.autoHide
			width: hoverArea.containsMouse ? 0 : background.width
			height: background.height
			color: "black"
			Behavior on width {
				NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
			}
			Text {
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: parent.right
				anchors.rightMargin: 2
				text: root.symbol
				color: root.colour

				font { pointSize: fontSize; family: fontFamily; }
				opacity: hoverArea.containsMouse ? 0 : 1
				Behavior on opacity {
					NumberAnimation { duration: 200; }
				}
			}
		}
	}
}

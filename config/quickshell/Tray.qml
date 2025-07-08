/*----------------------------
--- Tray widget by andrel ---*
----------------------------*/

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "root:"
import "root:tray"

Item { id: root
	readonly property Repeater items: items

	property int iconSize: GlobalConfig.iconSize
	property int menuMargin: 17

	property bool autoHide: false
	property string background: GlobalConfig.colour.background
	property int fontSize: GlobalConfig.font.size
	property string fontFamily: GlobalConfig.font.mono
	property string colour: GlobalConfig.colour.foreground
	property string symbol: "<"

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

	// draw tray and tray items
	Rectangle { id: tray
		width: parent.width
		height: parent.height
		color: "transparent"

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
					colour: root.colour
				}
			}
		}

		// draw rectangle over tray to hide items; hover to reveal
		Rectangle { id: hideContent
			visible: root.autoHide
			width: hoverArea.containsMouse ? 0 : tray.width
			height: tray.height
			topRightRadius: root.iconSize/2; bottomRightRadius: root.iconSize/2;
			color: root.background
			Behavior on width {
				NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
			}

			// tray indicator symbol
			Text { id: indicatoy
				height: tray.height
				verticalAlignment: Text.AlignVCenter
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: parent.right
				anchors.rightMargin: 2
				text: root.symbol
				color: root.colour
				opacity: hoverArea.containsMouse ? 0 : 100
				Behavior on opacity {
					NumberAnimation { duration: 200; }
				}
				transform: Rotation {
					origin.x: indicator.width /2; origin.y: indicator.height /2;
					angle: hoverArea.containsMouse ? 180 : 0
				}
				font { pointSize: root.fontSize; family: root.fontFamily; }
			}
		}
	}
}

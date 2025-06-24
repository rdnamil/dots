import Quickshell.Services.SystemTray
import QtQuick
import "root:"
import "root:services"

Item { id: root
	property int spacing: Config.spacing
	property int iconSize: 14
	property int menuMargin: 17
	readonly property Repeater items: items

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

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
}

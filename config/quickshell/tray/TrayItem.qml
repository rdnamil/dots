pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import Qt5Compat.GraphicalEffects
import "root:"

MouseArea { id: root

	property string colour: Config.colour.foreground

	required property int iconSize
	required property int menuMargin
	required property SystemTrayItem modelData

	acceptedButtons: Qt.LeftButton | Qt.RightButton
	implicitWidth: iconSize
	implicitHeight: iconSize

	onClicked: event => {
		if (event.button === Qt.LeftButton)
			modelData.activate();
		else if (modelData.hasMenu)
			menu.open();
	}

	QsMenuAnchor {
		id: menu

		menu: root.modelData.menu
		anchor.item: root
		anchor.margins.top: root.menuMargin
	}

	IconImage {
		id: icon

		source: {
			let icon = root.modelData.icon;
			if (icon.includes("?path=")) {
				const [name, path] = icon.split("?path=");
				icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
			}
			return icon;
		}
		asynchronous: true
		anchors.fill: parent; anchors.verticalCenter: parent.verticalCenter
		// layer.enabled: true
		// layer.effect: ColorOverlay {
		// 		color: root.colour
		// 	}
	}
}

import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow { id: root
	property int height: 26
	property string colour: Config.colour.background
	property int spacing: Config.spacing
	property int padding: Config.padding

	property list<Item>  leftItems
	property list<Item>  centreItems
	property list<Item>  rightItems

	anchors { top: true; left: true; right: true }
	implicitHeight: root.height
	color: "transparent"

	Item { id: bar
		anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; }
		width: root.width
		height: root.height

		Rectangle { id: background
			anchors.fill: parent
			color: root.colour
		}

		RowLayout {
			anchors { fill: parent; leftMargin: root.padding; rightMargin: root.padding; }

			RowLayout { id: leftRow
				anchors.verticalCenter: parent.verticalCenter
				Layout.fillWidth: true
				spacing: root.spacing
			}
			RowLayout { id: centreRow
				anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; }
				Layout.fillWidth: true
				spacing: root.spacing

			}
			RowLayout { id: rightRow
				anchors.verticalCenter: parent.verticalCenter;
				Layout.fillWidth: true
				spacing: root.spacing
				Item { Layout.fillWidth: true; }
			}
		}
	}

	Component.onCompleted: {
		for (var item of leftItems) item.parent = leftRow
		for (var item of centreItems) item.parent = centreRow
		for (var item of rightItems) item.parent = rightRow
	}
}

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import "widgets"

PanelWindow { id: root
	property int height: 34
	property int radius: 9
	property string colour: Config.colour.background
	property int padding: Config.padding
	property int spacing: Config.spacing
	property list<Item>  leftItems
	property list<Item>  centreItems
	property list<Item>  rightItems

	anchors { top: true; left: true; right: true }
	implicitHeight: root.height
	color: "transparent"

	Rectangle { id: background
		anchors.fill: parent
		color: root.colour
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: background.width
				height: background.height
				color: "transparent"
				visible: false
				Rectangle {
					anchors.top: parent.bottom; anchors.topMargin: - root.radius
					width: parent.width
					height: root.radius *2
					radius: root.radius
					color: "black"
				}
			}
			invert: true
		}
	}

	Item { id: bar
		anchors.top: root.top
		width: root.width
		height: root.height - root.radius

		RowLayout {
			anchors { fill: parent; leftMargin: root.padding; rightMargin: root.padding }

			RowLayout { id: leftRow
				Layout.fillWidth: true
				spacing: root.spacing
				// Item { Layout.fillWidth: true; }
			}
			RowLayout { id: centreRow
				Layout.fillWidth: true
				spacing: root.spacing
				anchors.horizontalCenter: parent.horizontalCenter
			}
			RowLayout { id: rightRow
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

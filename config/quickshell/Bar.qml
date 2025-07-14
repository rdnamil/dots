/*------------------------------
--- Horizontal bar by andrel ---
------------------------------*/

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell

PanelWindow { id: root
	property int height: 26
	property string position: "top"
	property string colour: GlobalConfig.colour.background
	property int spacing: GlobalConfig.spacing
	property int padding: GlobalConfig.padding
	property int cornerRadius: GlobalConfig.cornerRadius

	property list<Item>  leftItems
	property list<Item>  centreItems
	property list<Item>  rightItems

	anchors {
		top: root.position === 'top'
		bottom: root.position === 'bottom'
		left: true
		right: true
	}
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

	Rectangle { id: topLeft
		color: "black"

		anchors.top: parent.top; anchors.left: parent.left;

		width: bar.width; height: cornerRadius;
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: topLeft.width
				height: topLeft.height
				color: "transparent"
				visible: false
				Rectangle {
					anchors {
						verticalCenter: root.position === 'top' ? parent.bottom : parent.top
						horizontalCenter: parent.verticalCenter
					}
					width: parent.width
					height: cornerRadius *2
					radius: cornerRadius
					color: "black"
				}
			}
			invert: true
		}
	}

	Component.onCompleted: {
		for (var item of leftItems) item.parent = leftRow
		for (var item of centreItems) item.parent = centreRow
		for (var item of rightItems) item.parent = rightRow
	}
}

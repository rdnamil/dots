import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell

PanelWindow { id: root
	property int radius: 9
	property string colour: Config.colour.background

	anchors { bottom: true; left: true; right: true }
	implicitHeight: root.radius
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
					anchors.bottom: parent.top; anchors.bottomMargin: - root.radius
					width: parent.width
					height: root.radius *2
					radius: root.radius
					color: "black"
				}
			}
			invert: true
		}
	}
}

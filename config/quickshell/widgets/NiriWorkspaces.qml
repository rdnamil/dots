/*--------------------------------------
--- Niri workspaces widget by andrel ---
--------------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Io
import "root:"
import "niriWorkspaces"

Item { id: root
	// command to run on mouse pressed
	property list<string> command: ["niri", "msg", "action", "focus-workspace", root.workspace]
	property string colour: GlobalConfig.colour.foreground
	property int spacing: GlobalConfig.spacing
	property Highlight highlight: Highlight {}
	component Highlight: QtObject {
		property int width: 16
		property int height: 8
	}
	property NotHighlight notHighlight: NotHighlight {}
	component NotHighlight: QtObject {
		property int width: 8
		property int height: 8
	}
	property int workspace: 1

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

	Process { id: focusSpace
		running: false
		command: root.command
	}

	Row { id: layout
		anchors.verticalCenter: parent.verticalCenter

		spacing: root.spacing

		Repeater { id: workspaces
			model: NiriWorkspaces.numSpaces

			MouseArea {
				anchors.verticalCenter: parent.verticalCenter

				implicitWidth: pill.width
				implicitHeight: pill.height

				onClicked: {
					root.workspace = index +1
					focusSpace.running = true
				}

				// pills indicator
				Rectangle { id: pill
					readonly property bool isCurrentSpace: index === (NiriWorkspaces.currentSpaces -1)

					width: isCurrentSpace ? root.highlight.width : root.notHighlight.width
					height: isCurrentSpace ? root.highlight.height : root.notHighlight.height
					radius: height/2
					color: isCurrentSpace ? root.colour : "#6e738d"

					Behavior on width {
						NumberAnimation { duration: 150; }
					}
					Behavior on height {
						NumberAnimation { duration: 150; }
					}
					Behavior on color {
						ColorAnimation { duration: 150; }
					}
				}
			}
		}
	}
}

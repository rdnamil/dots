/*---------------------------------------
--- Niri workspaces widget by andrel ---*
---------------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Io
import "root:"
import "root:niriWorkspaces"

Item { id: root
	// command to run on mouse pressed
	property list<string> command: ["niri", "msg", "action", "focus-workspace", root.space]
	property string colour: GlobalConfig.colour.foreground
	property int spacing: GlobalConfig.spacing
	property Highlight highlight: Highlight {}
	property NotHighlight notHighlight: NotHighlight {}

	component Highlight: QtObject {
		property int width: 16
		property int height: 8
	}

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
					width: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight.width : root.notHighlight.width
					height: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight.height : root.notHighlight.height
					color: root.colour
					radius: height/2
					Behavior on width {
						NumberAnimation { duration: 150; }
					}
					Behavior on height {
						NumberAnimation { duration: 150; }
					}
				}
			}
		}
	}
}

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
	property int workspace: 1

	// defaults for pills indicator
	property int thickness: 8

	// defaults for text indicator
	property string fontFamily: GlobalConfig.font.mono
	property int fontSize: GlobalConfig.font.size

	property bool kara: true
	property int spacing: GlobalConfig.spacing

	property Highlight highlight: Highlight {}
	property NotHighlight notHighlight: NotHighlight {}

	component Highlight: QtObject {
		property int size: 16
		property string colour: GlobalConfig.colour.foreground
		property string text: ""
	}

	component NotHighlight: QtObject {
		property int size: 8
		property string colour: GlobalConfig.colour.foreground
		property string text: ""
	}

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

	Process { id: focusSpace
		running: false
		command: root.command
	}

	Row { id: layout
		spacing: root.spacing

		Repeater { id: workspaces
			model: NiriWorkspaces.numSpaces

			MouseArea {

				implicitWidth: root.kara ? pill.width : text.width
				implicitHeight: root.kara ? pill.height : text.height

				onClicked: {
					root.workspace = index +1
					focusSpace.running = true
				}

				// pills indicator
				Rectangle { id: pill
					visible: root.kara
					height: root.thickness; radius: root.thickness/2;
					width: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight.size : root.notHighlight.size
					color: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight.colour : root.notHighlight.colour
					Behavior on width {
						NumberAnimation { duration: 150; }
					}
					Behavior on color {
						ColorAnimation { duration: 150; }
					}
				}

				// text indicator
				Text { id: text
					visible: !root.kara
					text: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight.text : root.notHighlight.text
					color: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight.colour : root.notHighlight.colour
					font { pointSize: root.fontSize; family: root.fontFamily }
				}
			}
		}
	}
}

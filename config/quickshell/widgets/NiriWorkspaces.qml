import QtQuick
import Quickshell
import "root:"
import "root:services"

Item { id: root
	property int spacing: Config.spacing
	property string colour: Config.colour.foreground
	property string fontFamily: Config.font.mono
	property int fontSize: Config.font.size
	property string highlight: ""
	property string notHighlight: ""

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

	Row { id: layout
		spacing: root.spacing

		Repeater { id: workspaces
			model: NiriWorkspaces.numSpaces

			Text {
				text: index === (NiriWorkspaces.currentSpaces -1) ? root.highlight : root.notHighlight
				color: root.colour
				font { pointSize: fontSize; family: fontFamily }
			}
		}
	}
}

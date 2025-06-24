import QtQuick
import Quickshell
import "root:"
import "root:services"


MouseArea { id: root
	property string format: "hh:mm:ss a"
	property string colour: Config.colour.foreground
	property string fontFamily: Config.font.family
	property int fontSize: Config.font.size

	implicitWidth: text.width
	implicitHeight: text.height

	Text { id: text
		text: Time.format(format)
		color: colour
		font { pointSize: fontSize; family: fontFamily }
	}
}

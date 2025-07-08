/*-----------------------------
--- Clock widget by andrel ---*
-----------------------------*/

import QtQuick
import Quickshell
import "root:"
import "root:clock"


MouseArea { id: root
	property string format: "hh:mm:ss a"
	property string colour: GlobalConfig.colour.foreground
	property string fontFamily: GlobalConfig.font.sans
	property int fontSize: GlobalConfig.font.size
	property int fontWeight: GlobalConfig.font.semibold

	implicitWidth: text.width
	implicitHeight: text.height

	Text { id: text
		text: Time.format(format)
		color: colour
		font { pointSize: fontSize; family: fontFamily; weight: fontWeight; }
	}
}

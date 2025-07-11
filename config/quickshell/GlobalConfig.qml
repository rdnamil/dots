pragma Singleton

import Quickshell
import QtQuick

Singleton { id: root
	readonly property Colour colour: Colour {}
	readonly property Font font: Font {}

	readonly property int padding: 10
	readonly property int spacing: 6
	readonly property int iconSize: 16
	readonly property int cornerRadius: 16

	component Colour: QtObject {
		readonly property string foreground: "#cad3f5"
		readonly property string background: "#24273a"
	}

	component Font: QtObject {
		readonly property string sans: "Adwaita Sans Regular"
		readonly property string mono: "JetBrains Mono Nerd Font"
		readonly property int size: 11
		readonly property int small: 8
		readonly property int semibold: 500
	}
}

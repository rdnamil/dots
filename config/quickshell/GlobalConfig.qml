pragma Singleton

import Quickshell
import QtQuick

Singleton { id: root
	readonly property Colour colour: Colour {}
	readonly property Font font: Font {}

	readonly property int padding: 10
	readonly property int spacing: 4
	readonly property int iconSize: 16

	component Colour: QtObject {
		readonly property string foreground: "#cad3f5"
		readonly property string background: "black"
	}

	component Font: QtObject {
		readonly property string sans: "Adwaita Sans Regular"
		readonly property string mono: "JetBrains Mono Nerd Font"
		readonly property int size: 11
		readonly property int semibold: 500
	}
}

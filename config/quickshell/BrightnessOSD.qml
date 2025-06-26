import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "root:services"

Scope { id: root

	property bool shouldShowOsd: false

	Connections {
		target: Brightness

		function oncurrentBrightChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {
			anchors.bottom: true
			margins.bottom: screen.height / 3

			implicitWidth: 200
			implicitHeight: 30
			color: "transparent"
			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: height / 2
				color: "#f0000000"

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}
					spacing: 8

					IconImage {
						implicitSize: 16
						source: "root:/icons/brightness"
					}

					Rectangle {
						Layout.fillWidth: true

						implicitHeight: 5
						radius: 20
						color: "#50ffffff"

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}
							color: "#cad3f5"

							implicitWidth: parent.width * ((Brightness.currentBright / Brightness.maxBright))
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}

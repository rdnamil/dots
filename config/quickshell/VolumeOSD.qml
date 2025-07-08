import QtQuick
import QtMultimedia
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Wayland

Scope {
	id: root

	// Bind the pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onMutedChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	property bool shouldShowOsd: false

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	// The OSD window will be created and destroyed based on shouldShowOsd.
	// PanelWindow.visible could be set instead of using a loader, but using
	// a loader will reduce the memory overhead when the window isn't open.
	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {
			WlrLayershell.layer: WlrLayer.Overlay
			// Since the panel's screen is unset, it will be picked by the compositor
			// when the window is created. Most compositors pick the current active monitor.

			anchors.bottom: true
			margins.bottom: screen.height / 3

			implicitWidth: 200
			implicitHeight: 30
			color: "transparent"

			// An empty click mask prevents the window from blocking mouse events.
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
						source: {
							let icon = "root:icons/audio/high"
							if ((Pipewire.defaultAudioSink?.audio.muted ?? true) || (Pipewire.defaultAudioSink?.audio.volume ?? 0) < 0.01) {
								icon = "root:icons/audio/muted"
							} else if ((Pipewire.defaultAudioSink?.audio.volume ?? 0) >= 0.01 && (Pipewire.defaultAudioSink?.audio.volume ?? 0) < 0.33)  {
								icon = "root:icons/audio/low"
							} else if ((Pipewire.defaultAudioSink?.audio.volume ?? 0) >= 0.33 && (Pipewire.defaultAudioSink?.audio.volume ?? 0) < 0.66) {
								icon = "root:icons/audio/medium"
							} else if ((Pipewire.defaultAudioSink?.audio.volume ?? 0) >= 0.66) {
								icon = "root:icons/audio/high"
							}
							return icon;
						}
					}

					Rectangle {
						// Stretches to fill all left-over space
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

							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}

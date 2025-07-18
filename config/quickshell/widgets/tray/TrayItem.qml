pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "root:"

Item { id: root
	required property SystemTrayItem modelData

	property int iconSize
	property int cornerRadius
	property int menuSpacing
	property int menuMargins
	property string colourMenu
	property string colourText
	property string colourAccent

	signal menuOpened(var menu)
	signal menuClosed(var menu)

	width: icon.width
	height: icon.height

	IconImage { id: icon
		anchors.centerIn: parent
		implicitSize: iconSize
		source: root.modelData.icon
	}

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		onClicked: event => {
			menuWindow.anchor.updateAnchor();
			if (event.button === Qt.LeftButton) {
				if (menuWindow.visible) {
					menuWindow.close()
					root.menuClosed(menuWindow)
				} else {
					modelData.activate();
					root.menuOpened(menuWindow)
					root.menuClosed(menuWindow)
				}
			} else if (modelData.hasMenu) {
				if (!menuWindow.visible) {
					menuWindow.open()
					root.menuOpened(menuWindow)
				} else {
					menuWindow.close()
					root.menuClosed(menuWindow)
				}
			}
		}
	}

	// use system context menu
	QsMenuAnchor { id: menuTemp
		menu: root.modelData.menu
		anchor.item: root
		anchor.margins.top: GlobalConfig.barHeight
	}

	// custom menu window
	PopupWindow { id: menuWindow
		anchor { item: root; rect { x: root.width /2 -width /2; y: root.height +6; }}
		width: menu.width
		height: menu.height +menuSpacing
		color: "transparent"
		visible: false

		Item { id: menu
			// space menu entries if button exists
			property bool hasButton: false
			property bool hasChildren: false

			function updateHasButton() {
				hasButton = true
			}

			function updateHasChildren() {
				hasChildren = true
			}

			implicitWidth: layout.width +menuMargins +cornerRadius *2
			implicitHeight: layout.height +menuMargins
			y: -height

			Behavior on y { NumberAnimation{ duration: 300; easing.type: Easing.OutCubic; }}

			Rectangle { id: menuBack
				anchors.centerIn: parent
				implicitWidth: layout.width +menuMargins
				implicitHeight: layout.height +menuMargins
				radius: cornerRadius
				color: colourMenu
			}

			// get menu handle
			QsMenuOpener { id: menuOpener
				menu: modelData.menu
			}

			// menu entries
			ColumnLayout { id: layout
				anchors.centerIn: parent

				Repeater {
					model: menuOpener.children

					Item { id: menuChild
						required property QsMenuHandle modelData

						implicitWidth: modelData.isSeparator? menuSeparator.width +cornerRadius : textEntry.width +cornerRadius
						implicitHeight: modelData.isSeparator? menuSeparator.height : textEntry.height +menuSpacing

						// trigger function if any menu entries has button
						Component.onCompleted: {
							if (menuChild.modelData.buttonType === (QsMenuButtonType.CheckBox || QsMenuButtonType.RadioButton)) {
								menu.updateHasButton();
							}
							if (menuChild.modelData.hasChildren) {
								menu.updateHasChildren();
							}
						}

						Rectangle { id: highlightEntry
							width: layout.width
							height: menuChild.height
							radius: 4
							color: colourAccent
							opacity: 0.25
							visible: hoverArea.containsMouse && !menuChild.modelData.isSeparator
						}

						Rectangle { id: menuSeparator
							anchors.centerIn: parent
							visible: menuChild.modelData.isSeparator
							width: layout.width -cornerRadius
							height: 1
							opacity: 0.1
							color: colourText
						}

						Rectangle { id: arrow
							anchors.right: highlightEntry.right
							visible: menu.hasChildren
							width: layout.width - menuChild.width
							height: menuChild.height
							color: "transparent"

							IconImage {
								anchors{ verticalCenter: arrow.verticalCenter; right: arrow.right; }
								visible: modelData.hasChildren
								implicitSize: text.height
								source: Quickshell.iconPath("draw-arrow-forward")
							}
						}

						Row { id: textEntry
							spacing: menuSpacing
							anchors.centerIn: parent

							// space text if menu has entry with button
							Rectangle { id: buttonSpacer
								visible: menu.hasButton && menuChild.modelData.buttonType === QsMenuButtonType.None
								implicitWidth: text.height
								implicitHeight: text.height
								color: "transparent"
							}

							IconImage { id: checkBox
								visible: menuChild.modelData.buttonType === QsMenuButtonType.CheckBox
								implicitSize: text.height
								source: {
									switch (menuChild.modelData.checkState) {
										case Qt.Checked:
											return Quickshell.iconPath("checkbox-checked-symbolic");
											break;
										case Qt.PartiallyChecked:
											return Quickshell.iconPath("checkbox-mixed-symbolic");
											break
										default:
											return Quickshell.iconPath("checkbox-symbolic");
									}
								}
							}

							IconImage { id: radioButton
								visible: menuChild.modelData.buttonType === QsMenuButtonType.RadioButton
								implicitSize: text.height
								source: {
									switch (menuChild.modelData.checkState) {
										case Qt.Checked:
											return Quickshell.iconPath("radio-checked-symbolic");
											break;
										case Qt.PartiallyChecked:
											return Quickshell.iconPath("radio-mixed-symbolic");
											break
										default:
											return Quickshell.iconPath("radio-symbolic");
									}
								}
							}

							IconImage {
								visible: menuChild.modelData.icon
								source: menuChild.modelData.icon
								implicitSize: text.height
							}

							Text { id: text
								visible: !menuChild.modelData.isSeparator
								text: menuChild.modelData.text
								font.pointSize: 11
								color: colourText
							}

							Rectangle { id: arrowSpacer
								visible: menuChild.modelData.hasChildren
								implicitWidth: text.height
								implicitHeight: text.height
								color: "transparent"
							}
						}

						MouseArea { id: hoverArea
							width: layout.width
							height: menuChild.height
							hoverEnabled: true
							onClicked: event => {
								menuChild.modelData.triggered()
								menuTemp.open()
								menuTemp.close()
								menuWindow.close()
							}
						}
					}
				}
			}
		}

		function open () {
			visible = true
			menu.y = menuSpacing
		}
		function close() {
			visible = false
			menu.y = -menu.height
		}
	}
}

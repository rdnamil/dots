/*---------------------------
--- Tray widget by andrel ---
---------------------------*/

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "root:"
import "tray"

Item { id: root
	property var openMenu: null
	property int iconSize: GlobalConfig.iconSize
	property int cornerRadius: GlobalConfig.cornerRadius
	property int menuSpacing: GlobalConfig.spacing
	property int menuMargins: GlobalConfig.padding
	property string colourMenu: GlobalConfig.colour.background
	property string colourText: GlobalConfig.colour.foreground
	property string colourAccent: GlobalConfig.colour.accent

	implicitWidth: layout.width
	implicitHeight: layout.height

	Row { id: layout
		spacing: 2

		Repeater { id: trayItems
			model: SystemTray.items

			TrayItem {
				iconSize: root.iconSize
				cornerRadius: root.cornerRadius
				menuSpacing: root.menuSpacing
				menuMargins: root.menuMargins
				colourMenu: root.colourMenu
				colourText: root.colourText
				colourAccent: root.colourAccent

				// close any other opened menus
				onMenuOpened: (menuInstance) => {
					if (root.openMenu && root.openMenu !== menuInstance) {
						root.openMenu.close()
					}
					root.openMenu = menuInstance
				}

				onMenuClosed: (menuInstance) => {
					if (root.openMenu === menuInstance) {
						root.openMenu = null
					}
				}
			}
		}
	}
}

import Quickshell.Services.SystemTray
import QtQuick
import "./config.js" as Config

Row {
    spacing: Config.tray.spacing
    Repeater {
        model: SystemTray.items
        TrayItem {}
    }
}

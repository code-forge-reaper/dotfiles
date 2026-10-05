import Quickshell.Hyprland
import QtQuick
import "./config.js" as Config

Row {
    spacing: Config.workspaces.spacing
    Repeater {
        model: Config.workspaces.count
        Text {
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            text: index + 1
            color: isActive ? Config.workspaces.active : Config.workspaces.inactive
            font.bold: true

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace=${index + 1}})`)
            }
        }
    }
}

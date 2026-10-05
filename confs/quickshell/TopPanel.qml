import "./config.js" as Config
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Config.top.height
    color: Config.generic.transparent   // was Config.top.color

    Rectangle {
        anchors.fill: parent
        radius: Config.top.radius
        color: Config.top.color

        // Optional: a hairline so the rounded edge reads on light backgrounds
        // border.width: 1
        // border.color: Config.generic.muted

        RowLayout {
            anchors.fill: parent
            Item {
                Layout.fillWidth: true
            }
            Workspaces {}
            ToolSeparator {
                Layout.fillHeight: true
            }
            Battery {}
            Item {
                Layout.fillWidth: true
            }
        }
    }
}

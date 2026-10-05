import "./config.js" as Config
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: trayWindow
    anchors {
        bottom: true
        left: true
        right: true
    }

    color: Config.tray.color
    implicitHeight: Config.tray.height

    RowLayout {
        anchors.fill: parent
        Volume {}
        ToolSeparator {
            Layout.fillHeight: true
        }
        Clock {}
        ToolSeparator {
            Layout.fillHeight: true
        }
        Tray {}

        // This invisible Item expands to push everything after it to the far-right
        Item {
            Layout.fillWidth: true
        }

        NotificationManager {}
    }
}

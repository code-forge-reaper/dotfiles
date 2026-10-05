import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "./config.js" as Config

PanelWindow {
    id: center
    required property var history
    visible: false

    anchors {
        right: true
        bottom: true
    }
    margins {
        top: Config.notifs.panelScreenMargin
        right: Config.notifs.panelScreenMargin
    }

    implicitWidth: Config.notifs.panelWidth
    implicitHeight: Math.min(col.implicitHeight + Config.dims.marginLarge * 2, Config.notifs.panelMaxHeight)
    exclusionMode: ExclusionMode.Ignore
    color: Config.generic.transparent

    Process {
        id: closeNotificationIpc
        command: ["qs", "ipc", "call", "notifications", "close"]
        onExited: closeNotificationIpc.running = false
    }
    Rectangle {

        anchors.fill: parent
        radius: Config.dims.radius
        color: Config.generic.card
        border.width: Config.dims.border
        border.color: Config.notifs.border

        ColumnLayout {
            id: col
            anchors.fill: parent
            anchors.margins: Config.dims.marginLarge
            spacing: Config.dims.spacing

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ColumnLayout {
                    width: parent.width
                    spacing: Config.dims.spacing

                    Repeater {
                        model: center.history
                        NotificationPanel {
                            onRemoveRequested: center.history.remove(index)
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text {
                    Layout.fillWidth: true
                    text: "Close"
                    color: Config.generic.text
                    font {
                        family: Config.font
                        pixelSize: Config.dims.fontSizeTitle
                        bold: true
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onPressed: closeNotificationIpc.running = true
                    }
                }

                Text {
                    Layout.fillWidth: true
                    text: "Notifications"
                    color: Config.generic.title
                    font {
                        family: Config.font
                        pixelSize: Config.dims.fontSizeTitle
                        bold: true
                    }
                }

                Text {
                    text: "Clear all"
                    visible: center.history.count > 0
                    color: Config.generic.accent
                    font {
                        family: Config.font
                        pixelSize: Config.dims.fontSize
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: center.history.clear()
                    }
                }
            }
        }
    }
}

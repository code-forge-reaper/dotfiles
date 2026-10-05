import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import "./config.js" as Config

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    ListModel {
        id: history
    }

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            n.tracked = true;
            history.insert(0, {
                summary: n.summary || "",
                body: n.body || "",
                appName: n.appName || "",
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm"),
                image: n.image || "",
                appIcon: n.appIcon || "",
                icon: n.icon || ""
            });
        }
    }

    NotificationDaemon {
        server: server
    }

    NotificationCenter {
        id: center
        history: history
    }

    IpcHandler {
        target: "notifications"
        function toggle(): void {
            center.visible = !center.visible;
        }
        function open(): void {
            center.visible = true;
        }
        function close(): void {
            center.visible = false;
        }
        function clear(): void {
            history.clear();
        }
    }

    Text {
        id: label
        anchors.fill: parent
        text: history.count > 0 ? `[${history.count}]` : ""
        color: Config.generic.text
        font.pixelSize: 20
        // todo: right-click = history.clear
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: {
                left: true;
                right: true;
            }
            onClicked: function (mouse) {
                if (mouse.button === Qt.RightButton)
                    history.clear();
                else
                    center.visible = !center.visible;
            }
        }
    }
}

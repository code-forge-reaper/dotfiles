import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "./config.js" as Config

PanelWindow {
    id: daemon
    required property NotificationServer server

    anchors {
        top: true
        right: true
    }
    margins {
        top: Config.notifs.popupMargin
        right: Config.notifs.popupMargin
    }

    implicitWidth: Config.notifs.popupWidth
    implicitHeight: Math.max(1, col.implicitHeight)
    color: Config.generic.transparent
    exclusionMode: ExclusionMode.Ignore

    ColumnLayout {
        id: col
        width: parent.width
        spacing: Config.dims.spacing

        Repeater {
            model: daemon.server.trackedNotifications
            NotificationCard {}
        }
    }
}

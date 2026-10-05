import Quickshell
import QtQuick
import "./config.js" as Config

Item {
    implicitWidth: clockText.implicitWidth
    implicitHeight: clockText.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: clockText
        anchors.fill: parent

        text: Qt.formatDateTime(clock.date, Config.clock.format)
        color: Config.generic.text
        font.pixelSize: Config.clock.fontSize
    }
}

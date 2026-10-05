import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "./config.js" as Config

Rectangle {
    id: card
    required property var modelData

    Layout.fillWidth: true
    Layout.preferredHeight: layout.implicitHeight + Config.dims.margin * 2
    radius: Config.dims.radius
    color: Config.generic.card

    border.width: Config.dims.borderThick
    border.color: modelData.urgency === NotificationUrgency.Critical ? Config.notifs.borderCritical : Config.notifs.border

    Timer {
        running: modelData.urgency !== NotificationUrgency.Critical
        interval: Config.notifs.timeout
        onTriggered: card.modelData.dismiss()
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: Config.dims.margin
        spacing: Config.dims.spacing

        Image {
            Layout.preferredHeight: Config.dims.iconSize
            Layout.preferredWidth: Config.dims.iconSize
            Layout.alignment: Qt.AlignTop
            fillMode: Image.PreserveAspectFit
            source: card.modelData.image || card.modelData.appIcon || card.modelData.icon || ""
            visible: source.toString() !== ""
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: Config.dims.spacingTiny

            Text {
                visible: text !== ""
                wrapMode: Text.WordWrap
                font {
                    family: Config.font
                    pixelSize: Config.dims.fontSizeSmall
                }
                text: card.modelData.appName
                color: Config.generic.text
            }

            Text {
                visible: text !== ""
                Layout.fillWidth: true
                elide: Text.ElideRight
                font {
                    family: Config.font
                    pixelSize: Config.dims.fontSizeTitle
                }
                text: card.modelData.summary
                color: Config.generic.title
            }

            Text {
                visible: text !== ""
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font {
                    family: Config.font
                    pixelSize: Config.dims.fontSize
                }
                text: card.modelData.body
                color: Config.generic.text
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: card.modelData.dismiss()
    }
}

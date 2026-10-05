import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "./config.js" as Config

Rectangle {
    id: panel
    required property int index
    required property var modelData

    signal removeRequested

    Layout.fillWidth: true
    Layout.preferredHeight: layout.implicitHeight + Config.dims.margin * 2
    radius: Config.dims.radiusSmall
    color: Config.generic.card

    border.width: Config.dims.borderThick
    border.color: modelData.urgency === NotificationUrgency.Critical ? Config.notifs.borderCritical : Config.notifs.border

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: Config.dims.margin
        spacing: Config.dims.spacingSmall

        RowLayout {
            Layout.fillWidth: true
            spacing: Config.dims.spacing

            Image {
                Layout.preferredHeight: Config.dims.iconSize
                Layout.preferredWidth: Config.dims.iconSize
                Layout.alignment: Qt.AlignTop
                fillMode: Image.PreserveAspectFit
                source: panel.modelData.image || panel.modelData.appIcon || panel.modelData.icon || ""
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
                    text: panel.modelData.appName
                    color: Config.generic.text
                }

                Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    font {
                        family: Config.font
                        pixelSize: Config.dims.fontSizeTitle
                    }
                    text: panel.modelData.summary
                    color: Config.generic.title
                }

                Text {
                    font {
                        family: Config.font
                        pixelSize: Config.dims.fontSizeSubtitle
                    }
                    text: panel.modelData.time
                    color: Config.generic.muted
                }

                Text {
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    font {
                        family: Config.font
                        pixelSize: Config.dims.fontSize
                    }
                    text: panel.modelData.body
                    color: Config.generic.text
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: panel.removeRequested()
    }
}

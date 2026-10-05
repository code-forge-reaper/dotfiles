//@ pragma UseQApplication

import Quickshell
import QtQuick
import "./config.js" as Config

Item {
    width: Config.tray.icons.width
    height: Config.tray.icons.height

    QsMenuAnchor {
        id: menuAnchor
        anchor.window: trayWindow
        menu: modelData.menu
    }

    Image {
        anchors.fill: parent
        source: modelData.icon
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: mouse => {
            if (modelData.hasMenu)
                menuAnchor.open();
            else
                modelData.activate(0, 0);
        }
    }
}

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import "./config.js" as Config

Item {
    id: root
    implicitWidth: volText.implicitWidth
    implicitHeight: volText.implicitHeight

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property real volume: Pipewire.defaultAudioSink?.audio.volume ?? 0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false

    Text {
        id: volText
        anchors.fill: parent
        text: {
            if (root.muted || root.volume <= 0)
                return "vol: muted";
            return `vol: ${Math.round(root.volume * 100)}%`;
        }
        color: root.muted ? Config.generic.muted : Config.generic.title
        font.pixelSize: Config.volume.fontSize
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            if (!Pipewire.defaultAudioSink?.audio)
                return;
            if (mouse.button === Qt.LeftButton)
                Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
            else if (mouse.button === Qt.RightButton)
                Quickshell.execDetached(["pavucontrol"]);
        }

        onWheel: wheel => {
            if (!Pipewire.defaultAudioSink?.audio)
                return;
            if (Math.abs(wheel.angleDelta.y) < Config.volume.minMove)
                return;
            const step = Config.volume.step;
            let vol = Pipewire.defaultAudioSink.audio.volume;

            if (wheel.angleDelta.y > 0)
                Pipewire.defaultAudioSink.audio.volume = Math.min(1, vol + step);
            else
                Pipewire.defaultAudioSink.audio.volume = Math.max(0.0, vol - step);
        }
    }
}

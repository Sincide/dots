// Audio module using scripts/audio.sh. Supports click to mute and wheel for volume.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: audio
    script: config.home + "/scripts/audio.sh"
    interval: 3000

    // Override label to show icon + volume
    Text {
        id: label
        anchors.centerIn: parent
        text: (function() {
            var muted = !!(audio.payload && audio.payload.muted);
            var vol = (audio.payload && audio.payload.volume) ? audio.payload.volume : 0;
            return (muted ? "\uF6A9" : "\uF028") + " " + vol + "%";
        })()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        onClicked: {
            if (mouse.button === Qt.LeftButton) {
                Process { command: audio.script + " --click"; start() }
            } else if (mouse.button === Qt.MiddleButton) {
                Process { command: audio.script + " --middle"; start() }
            }
        }
        onWheel: {
            if (wheel.angleDelta.y > 0)
                Process { command: audio.script + " --scroll-up"; start() }
            else
                Process { command: audio.script + " --scroll-down"; start() }
        }
    }
}

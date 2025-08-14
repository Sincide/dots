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
        text: (audio.payload.muted ? "\uF6A9" : "\uF028") + " " + (audio.payload.volume || 0) + "%" // Font Awesome icons
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Process { command: audio.script + " --click"; start() }
        onWheel: {
            if (wheel.angleDelta.y > 0)
                Process { command: audio.script + " --scroll-up"; start() }
            else
                Process { command: audio.script + " --scroll-down"; start() }
        }
        onMiddleClicked: Process { command: audio.script + " --middle"; start() }
    }
}

// Microphone mute indicator using scripts/mic.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: mic
    script: config.home + "/scripts/mic.sh"
    interval: 3000

    Text {
        id: label
        anchors.centerIn: parent
        text: mic.payload.muted ? "\uF539" : "\uF130" // microphone icons
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Process { command: mic.script + " --toggle"; start() }
    }
}

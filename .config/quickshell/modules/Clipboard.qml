// Clipboard history size module using scripts/clipboard.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: clip
    script: config.home + "/scripts/clipboard.sh"
    interval: 5000

    Text {
        id: label
        anchors.centerIn: parent
        text: "\uF0EA " + (clip.payload.size || 0)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Process { command: clip.script + " --paste"; start() }
    }
}

// Package update checker using scripts/updates.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: up
    script: config.home + "/scripts/updates.sh"
    interval: 900000 // 15 min

    Text {
        id: label
        anchors.centerIn: parent
        text: "\uF062 " + (up.payload.total || 0)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Process { command: 'kitty -e yay -Syu'; start() } // open terminal for updates
    }
}

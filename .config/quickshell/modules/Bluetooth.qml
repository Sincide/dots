// Bluetooth module using scripts/bt.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: bt
    script: config.home + "/scripts/bt.sh"
    interval: 10000

    Text {
        id: label
        anchors.centerIn: parent
        text: bt.payload.powered ? "\uF5B0" : "\uF5B1" // bluetooth icons
    }
}

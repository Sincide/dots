// Power profile module using scripts/power.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: power
    script: config.home + "/scripts/power.sh"
    interval: 20000

    Text {
        id: label
        anchors.centerIn: parent
        text: "\uF011 " + (power.payload.profile || "?")
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Process { command: power.script + " --next"; start() }
    }
}

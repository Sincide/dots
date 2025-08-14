// Backlight module using scripts/backlight.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: back
    script: config.home + "/scripts/backlight.sh"
    interval: 5000

    Text {
        id: label
        anchors.centerIn: parent
        text: "\uF185 " + (back.payload.percent || 0) + "%" // sun icon
    }

    MouseArea {
        anchors.fill: parent
        onWheel: {
            if (wheel.angleDelta.y > 0)
                Process { command: back.script + " --scroll-up"; start() }
            else
                Process { command: back.script + " --scroll-down"; start() }
        }
    }
}

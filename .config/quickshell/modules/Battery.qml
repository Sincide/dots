// Battery module using scripts/battery.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: bat
    script: config.home + "/scripts/battery.sh"
    interval: 60000

    Text {
        id: label
        anchors.centerIn: parent
        text: bat.payload.percent ? "\uF240 " + bat.payload.percent + "%" : "\uF240" // battery icon
    }
}

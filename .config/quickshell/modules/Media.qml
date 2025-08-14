// Media player module using scripts/media.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: media
    script: config.home + "/scripts/media.sh"
    interval: 5000

    Text {
        id: label
        anchors.centerIn: parent
        text: media.payload.status == 'Playing' ? "\uF04B " + media.payload.title : "\uF04C" // play/pause icons
        elide: Text.ElideRight
        width: 150
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Process { command: media.script + " --play-pause"; start() }
        onWheel: {
            if (wheel.angleDelta.y > 0)
                Process { command: media.script + " --next"; start() }
            else
                Process { command: media.script + " --prev"; start() }
        }
    }
}

// Active window title module.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: win
    script: config.home + "/scripts/wm-active-window.sh"
    interval: 2000

    Text {
        id: label
        anchors.centerIn: parent
        text: win.payload.text || win.payload || ""
        elide: Text.ElideRight
        width: 200
    }
}

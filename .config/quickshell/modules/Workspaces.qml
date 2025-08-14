// Workspace indicator using scripts/wm-workspaces.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: ws
    script: config.home + "/scripts/wm-workspaces.sh"
    interval: 3000

    Row {
        anchors.centerIn: parent
        spacing: 4
        Repeater {
            model: (Array.isArray(ws.payload) ? ws.payload.length : 0)
            delegate: Rectangle {
                width: 12; height: 12; radius: 6
                color: ws.payload[index].active ? "#89b4fa" : "#585b70" // Catppuccin colors
            }
        }
    }
}

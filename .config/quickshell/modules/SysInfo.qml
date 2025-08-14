// System information module using scripts/sysinfo.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: sys
    script: config.home + "/scripts/sysinfo.sh"
    interval: 10000

    Text {
        id: label
        anchors.centerIn: parent
        text: Math.round((sys.payload.mem.used / sys.payload.mem.total) * 100) + "% RAM"
    }
}

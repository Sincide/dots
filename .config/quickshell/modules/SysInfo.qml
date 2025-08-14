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
        text: (function() {
            var m = sys.payload && sys.payload.mem;
            if (!m || !m.total || m.total === 0) return "-- RAM";
            return Math.round((m.used / m.total) * 100) + "% RAM";
        })()
    }
}

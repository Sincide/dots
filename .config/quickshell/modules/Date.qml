// Date/time module using scripts/date.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: date
    script: config.home + "/scripts/date.sh"
    interval: 1000

    Text {
        id: label
        anchors.centerIn: parent
        text: (function() {
            var iso = date.payload.iso;
            var d = iso ? new Date(iso) : new Date();
            if (isNaN(d.getTime())) d = new Date();
            return d.toLocaleString();
        })()
    }
}

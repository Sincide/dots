// Temperature sensor module using scripts/sensors.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: sens
    script: config.home + "/scripts/sensors.sh"
    interval: 10000

    Text {
        id: label
        anchors.centerIn: parent
        text: (function() {
            var s = sens.payload && sens.payload.sensors;
            if (!s || s.length === 0) return "--";
            var v = s[0] && s[0].temp1_input;
            return (v !== undefined && v !== null) ? (v + "°C") : "--";
        })()
    }
}

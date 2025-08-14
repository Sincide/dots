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
        text: sens.payload.sensors ? sens.payload.sensors[0].temp1_input + "°C" : "--"
    }
}

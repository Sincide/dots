// GPU utilization module.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: gpu
    script: config.home + "/scripts/gpu.sh"
    interval: 5000

    Text {
        id: label
        anchors.centerIn: parent
        text: "GPU " + (gpu.payload.util || 0) + "%"
    }
}

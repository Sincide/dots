// Network module using scripts/net.sh. Shows interface and IP.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: net
    script: config.home + "/scripts/net.sh"
    interval: 5000

    Text {
        id: label
        anchors.centerIn: parent
        text: net.payload.iface ? "\uF1EB " + net.payload.iface : "\uF1EB off" // Wi-Fi icon
    }
}

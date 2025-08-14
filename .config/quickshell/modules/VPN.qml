// VPN module using scripts/vpn.sh.
import QtQuick 2.15
import Quickshell 1.0

StatusModule {
    id: vpn
    script: config.home + "/scripts/vpn.sh"
    interval: 10000

    Text {
        id: label
        anchors.centerIn: parent
        text: vpn.payload.active ? "\uF023 VPN" : "\uF023" // lock icon
    }
}

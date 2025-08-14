// Bottom bar: system information modules.
import QtQuick 2.15
import Quickshell 1.0
import "../modules" as Modules

Rectangle {
    id: bar
    property var screen
    property var theme
    color: theme.mantle
    height: theme.tok.barHeight
    width: screen.geometry.width

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: theme.tok.spacing
        Modules.Network {}
        Modules.VPN {}
        Modules.Bluetooth {}
        Modules.Audio {}
        Modules.Mic {}
        Modules.Backlight {}
        Modules.Battery {}
        Modules.Power {}
        Modules.GPU {}
        Modules.Sensors {}
        Modules.SysInfo {}
        Modules.Clipboard {}
    }
}

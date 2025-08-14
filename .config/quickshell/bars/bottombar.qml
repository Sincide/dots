// Bottom bar: system information modules.
import QtQuick 2.15
import Quickshell 1.0
import "../styles" as Styles
import "../modules" as Modules

Rectangle {
    id: bar
    property var screen
    color: Styles.theme.mantle
    height: Styles.theme.tok.barHeight
    width: screen.geometry.width

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: Styles.theme.tok.spacing
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

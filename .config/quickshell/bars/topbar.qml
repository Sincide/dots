// Top bar: workspaces, window title, media controls, notifications.
import QtQuick 2.15
import Quickshell 1.0
import "../modules" as Modules

Rectangle {
    id: bar
    property var screen
    property var theme
    color: theme.background
    height: theme.tok.barHeight
    width: screen.geometry.width

    Row {
        id: left
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: theme.tok.spacing
        Modules.Workspaces {}
        Modules.ActiveWindow { width: 400 }
    }

    Row {
        id: right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: theme.tok.spacing
        Modules.Media { width: 200 }
        Modules.Updates {}
        Modules.Date {}
    }
}

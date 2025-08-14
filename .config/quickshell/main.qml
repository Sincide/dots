// Entry point for Quickshell. Spawns top/bottom bars per monitor and panels.
import QtQuick 2.15
import Quickshell 1.0
import "styles/theme.qml" as Theme
import "bars/topbar.qml" as TopBar
import "bars/bottombar.qml" as BottomBar
import "panels/configpanel.qml" as ConfigPanel
import "panels/notifpanel.qml" as NotifPanel

Quickshell {
    id: root
    property var theme: Theme.theme
    Component.onCompleted: {
        for (var i = 0; i < Quickshell.screens.length; ++i) {
            var s = Quickshell.screens[i]
            topComponent.createObject(root, {"screen": s})
            bottomComponent.createObject(root, {"screen": s})
        }
        configComponent.createObject(root)
        notifComponent.createObject(root)
    }

    Component { id: topComponent; TopBar {} }
    Component { id: bottomComponent; BottomBar {} }
    Component { id: configComponent; ConfigPanel {} }
    Component { id: notifComponent; NotifPanel {} }
}

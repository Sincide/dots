// Notification panel integrating with swaync (placeholder).
import QtQuick 2.15
import Quickshell 1.0

Rectangle {
    id: panel
    width: 300
    height: 400
    color: "#00000080"
    visible: false
    Text { anchors.centerIn: parent; text: "Notifications" }
}

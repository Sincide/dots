// Generic status module that runs a script periodically and exposes JSON data.
// Individual modules inherit from this component.

import QtQuick 2.15
import Quickshell 1.0

Item {
    id: root
    property string script: ""            // absolute path to backing script
    property int interval: 5000            // polling interval in ms
    property var payload: ({})             // parsed JSON from script
    property alias text: label.text
    width: label.implicitWidth + 8
    height: parent ? parent.height : 24

    // Text label showing script output; child modules can style further
    Text {
        id: label
        anchors.centerIn: parent
        text: payload.text || ""
    }

    // Periodically refresh by executing the script
    Timer {
        interval: root.interval
        running: true
        repeat: true
        onTriggered: proc.start()
    }

    Process {
        id: proc
        command: root.script
        onExited: {
            if (stdout.length > 0) {
                // Expect JSON from script
                payload = JSON.parse(stdout)
            }
        }
    }
}

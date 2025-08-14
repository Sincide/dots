// Configuration overlay panel allowing runtime tweaks.
import QtQuick 2.15
import Quickshell 1.0
import "../styles" as Styles

Rectangle {
    id: panel
    objectName: "configpanel"
    property var theme
    width: 300
    height: 400
    color: theme ? theme.surface0 : Styles.theme.surface0
    radius: 8
    visible: false

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8
        Text { text: "Config Panel"; font.bold: true }
        Slider { id: spacing; from: 0; to: 20; value: theme ? theme.tok.spacing : Styles.theme.tok.spacing }
    }
}

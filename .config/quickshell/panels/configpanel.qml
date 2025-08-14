// Configuration overlay panel allowing runtime tweaks.
import QtQuick 2.15
import Quickshell 1.0
import "../styles" as Styles

Rectangle {
    id: panel
    width: 300
    height: 400
    color: Styles.theme.surface0
    radius: 8
    visible: false

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8
        Text { text: "Config Panel"; font.bold: true }
        // Placeholder sliders/buttons - real implementation would bind to settings
        Slider { id: spacing; from: 0; to: 20; value: Styles.theme.tok.spacing }
    }
}

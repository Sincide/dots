// Theme loader combining Catppuccin colors and design tokens.
import QtQuick 2.15

QtObject {
    id: theme
    // Read colors from JSON file
    property var colors: JSON.parse(readFile(Qt.resolvedUrl("colors.json")))
    // Import tokens
    property QtObject tok: Qt.createQmlObject('import QtQuick 2.15; QtObject {}', theme)
    Component.onCompleted: {
        tok = Qt.createComponent(Qt.resolvedUrl('tokens.qml')).createObject(theme)
    }

    // Exposed palette
    readonly property color background: colors.base
    readonly property color foreground: colors.text

    function readFile(path) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', path, false);
        xhr.send();
        return xhr.responseText;
    }
}

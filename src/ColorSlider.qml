// Vertical "slider" control used in colorpicker
import QtQuick 2.11

Item {
    property int cursorHeight: 7
    property real value: (1 - pickerCursor.y / height)
    //width: 15; height: 300
    Item {
        id: pickerCursor
        width: parent.width
        Rectangle {
            x: -3
            y: -height * 0.5
            width: parent.width + 4
            height: cursorHeight
            border.color: "black"
            border.width: 1
            color: "transparent"
            Rectangle {
                anchors.fill: parent
                anchors.margins: 2
                border.color: "white"
                border.width: 1
                color: "transparent"
            }
        }
    }
    MouseArea {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        drag.target: this
        y: -Math.round(cursorHeight / 2)
        anchors.left: parent.left
        anchors.right: parent.right
        function handleMouse(mouse) {
            if (mouse.buttons & Qt.LeftButton) {
                pickerCursor.y = Math.max(0, Math.min(height, mouse.y))
            }
        }
        onPositionChanged: {
            handleMouse(mouse)
        }
        onPressed: handleMouse(mouse)
    }

    onVisibleChanged: {
        if (visible) {
            pickerCursor.y = -cursorHeight * 0.5
        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.3

Button {
    hoverEnabled: true
    // Allow to click on buttons and leave while pressing
    onHoveredChanged: {
        if (stopButton.state === 'stopOn') {
            stopButton.state = ''
        }
    }
    // Change the button color when it is pressed
    onPressed: {
        stopButton.state = 'stopOn'
        if (playPause.isConnected()) {
            playPause.stopClicked()
        }
    }
    // Specify the behavior of a button when it is clicked on
    onReleased: {
        stopButton.state = ''
        socket.sendTextMessage('{ "Message": "Stop" }')
        scoreTimeline.stopTimeline()
    }

    contentItem: Image {
        id: stopButton
        sourceSize.width: 30
        sourceSize.height: 30
        clip: true
        source: "Icons/stop_off.png"
        states: [
            State {
                name: "stopOn"
                PropertyChanges {
                    target: stopButton
                    source: "Icons/stop_on.png"
                }
            },
            State {
                name: "hoveredStop"
                PropertyChanges {
                    target: stopButton
                    source: "Icons/stop_hover.png"
                }
            }
        ]
    }
    background: Rectangle {
        id: zone
        color: "#202020"
    }
}

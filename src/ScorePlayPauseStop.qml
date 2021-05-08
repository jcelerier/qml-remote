import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12


Column{
    ScorePlayPause{id: playPause}
    //ScorePlayGlob{id: playGlob}
    ScoreStop{id: stop}
    ScoreReinitialize{id: reinitialize}
    //onplayPauseStopMessageReceived(var n){}
    Connections {
        target: scorePlayPauseStop
        function onPlayPauseStopMessageReceived(m){
            var messageObject = m.Message
            switch (messageObject) {
            case "Start":
                //send signal to playPause Button
                playPause.clicked();
                break;
            case "Stop":
                //send signal to stop Button
                stop.clicked();
                scoreControlSurfaces.clearListModel();
                break;
            case "Restart":
                //send signal to reinitialize Button
                reinitialize.clicked();
                break;
//            case "IntervalPaused":
//                playPause.clicked();
//                break;
//            case "IntervalResumed":
//                playPause.clicked();
//                break;
            }
        }
        function onScorePlayPauseStopMessageReceived(m){
            var messageObject = m.Message
            switch (messageObject) {
            case "IntervalPaused":
                playPause.pausePressInScore();
                console.log("pause Pressed")
                break;
            case "IntervalResumed":
                console.log("play Pressed")
                playPause.playPressInScore();

                break;

            }
        }
        //Connect play Pause buttons with the socket instance
        function onConnectedToScore(){
            playPause.connectedToScore();
        }
        function onDisconnectedFromScore(){
            playPause.disonnectedFromScore();
        }
    }
}

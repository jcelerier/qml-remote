import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.12

ListView {
    id: scoreControlSurfaceList
    spacing: 20
    anchors.left: parent.left
    anchors.margins: 5
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    height: parent.height
    orientation: ListView.Vertical
    clip: true
    snapMode: ListView.SnapToItem

    // ObjectModel's "model" data is the actual item that is going to be displayed
    model: ObjectModel {
        id: controlSurfacelist
    }

    // The Component will serve as a factory to create the individual ControlSurface visual items & data model
    Component {
        id: controlSurfaceDataModel
        Loader {
            id: controlSurface
            property string name
            property var path
            property var m
            signal appendControls(var m)
            signal modifyControl(var m)
            source: "ScoreControlSurface.qml"
            onLoaded: {
                controlSurface.appendControls(m)
            }
        }
    }

    // Receiving and handling messages about Control Surfaces from score
    Connections {
        target: scoreControlSurfaceList
        function onControlSurfacesMessageReceived(m) {
            var messageObject = m.Message
            function find(cond) {
                for (var i = 0; i < controlSurfacelist.count; ++i)
                    if (cond(controlSurfacelist.get(i)))
                        return i
                return null
            }
            //the index of m.Path in the listmodel
            var s = find(function (item) {
                return item.path === JSON.stringify(m.Path)
            })
            // Adding a control surface
            if (messageObject === "ControlSurfaceAdded") {
                if (s === null) {
                    let newSurfaceModel = controlSurfaceDataModel.createObject(
                            controlSurfacelist, {
                                "name": m.Name,
                                "path": JSON.stringify(m.Path),
                                "m": m
                            })
                    controlSurfacelist.insert(0, newSurfaceModel)
                }
            } // Removing a control surface
            else if (messageObject === "ControlSurfaceRemoved") {
                if (s !== null) {
                    controlSurfacelist.remove(s)
                }
            }
            /* Modifying a control in a control surface            */
            else if (messageObject === "ControlSurfaceControl") {
                if (s !== null) {
                    let controlSurface = controlSurfacelist.get(parseInt(s))
                    controlSurface.modifyControl(m)
                }
            }
        }
    }
}

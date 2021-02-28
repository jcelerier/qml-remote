import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.15

Rectangle{
    radius:9
    color: "#202020"
    ListView{
        id:triggerslist
        width: parent.width ;height:parent.height
        orientation: ListView.Horizontal
        clip: true
        spacing: 5
        snapMode: ListView.SnapToItem
        model:ListModel {
            id: triggerslistModel

            ListElement {
                name: "Trigger133"
            }
            ListElement {
                name: "Trigger2"
            }
            ListElement {
                name: "Trigger3"
            }
            ListElement {
                name: "Trigger133"
            }
            ListElement {
            name: "Trigger2"
            }
            ListElement {
                name: "Trigger3"
            }
            ListElement {
                name: "Trigger133"
          }
          ListElement {
              name: "Trigger2"
          }
          ListElement {
              name: "Trigger3"
          }
          ListElement {
              name: "Trigger133"
          }
          ListElement {
              name: "Trigger2"
          }
          ListElement {
              name: "Trigger3"
          }
      }
      delegate:OssiaTrigger{
          height:triggerslist.height
          sliderName: name
          }
    }

    //implementation de la fonction
    Connections {
        target: ossiaTimeSet
        function onTriggerMessageReceived(m){
            var messageObject = m.Message
            if(messageObject === "TriggerAdded"){
                triggerslistModel.insert(0,{ name:JSON.stringify(m.Path)});
            }
            else if(messageObject === "TriggerRemoved"){
                function find(cond) {
                  for(var i = 0; i < triggerslistModel.count; ++i) if (cond(triggerslistModel.get(i))) return i;
                  return null
                }
                var s = find(function (item) { return item.name === JSON.stringify(m.Path) }) //the index of m.Path in the listmodel
                triggerslistModel.setProperty(s, "colorstate", "#FF0000")
                triggerslistModel.setProperty(s, "name", "desactivated")
                // manque traitement a faire (par exemple changer la couleur d un trigger desactive, et le rendre immodifiable)
            }
          }
        }
}


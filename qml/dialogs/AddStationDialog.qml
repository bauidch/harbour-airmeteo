import QtQuick 2.5
import Sailfish.Silica 1.0
import ".."
import "../components"
import "../js/client.js" as Client

Dialog {
    id: stationsDialog

    SilicaFlickable {
        id: pageFlickable
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        DialogHeader {
            id: header
            acceptText: qsTr("Add")
            cancelText: qsTr("Cancel")
        }

        Column {
            id: column
            width: stationsDialog.width
            spacing: Theme.paddingLarge

            DialogHeader {
                title: qsTr("Station")
            }

            TextField {
                id: stationInput
                width: parent.width
                label: qsTr("Station")
                errorHighlight: false
                placeholderText: qsTr("ICAO Code")
                inputMethodHints: Qt.ImhPreferUppercase
                EnterKey.onClicked: parent.focus = true;
                onFocusChanged: {
                    if(text.length > 0) {
                       var data = Client.getAirportData(stationInput.text)
                       if (data[0].name === undefined) {
                           resultHeader.visible = true
                           stationNotFound.visible = true
                           stationInput.errorHighlight = true
                       } else {
                           stationInput.errorHighlight = false
                           resultHeader.visible = true
                           stationNotFound.visible = false

                           stationIcao.visible = true
                           stationIcao.text = data[0].icao

                           stationName.visible = true
                           stationName.text = data[0].name

                           stationLocation.visible = true
                           stationLocation.text = data[0].location

                           stationCountry.visible = true
                           stationCountry.text = data[0].country
                       }

                    }
                }
            }

            SectionHeader {
                id: resultHeader
                text: qsTr("Result")
                visible: false

            }

            Label {
                id: stationNotFound
                width: parent.width
                text: qsTr("Station not Found, try again")
                visible: false
            }
            Label {
                id: stationIcao
                width: parent.width
                text: "ZZZZ"
                visible: false
            }
            Label {
                id: stationName
                width: parent.width
                visible: false
            }
            Label {
                id: stationLocation
                width: parent.width
                visible: false
            }
            Label {
                id: stationCountry
                width: parent.width
                visible: false
            }

        }

    }

    allowedOrientations: defaultAllowedOrientations
    VerticalScrollDecorator {
        flickable: pageFlickable
    }
    onAccepted:{
        loadDataToStorage(stationInput.text)
        console.log(stationInput.text, stationName.text, stationLocation.text,stationCountry.text)
    }
}

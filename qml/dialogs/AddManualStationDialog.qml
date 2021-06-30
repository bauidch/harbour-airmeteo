import QtQuick 2.5
import Sailfish.Silica 1.0
import "../components"
import ".."
import "../pages"
import "../js/client.js" as Client

Dialog {
    id: stationsDialog
    property bool deactivateAccept: false
    canAccept: deactivateAccept

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
                EnterKey.onClicked: stationNameInput.focus = true;
            }

            TextField {
                id: stationNameInput
                width: parent.width
                label: qsTr("Name")
                errorHighlight: false
                placeholderText: qsTr("airport name")
                inputMethodHints: Qt.ImhPreferUppercase
                EnterKey.onClicked: stationLocationInput.focus = true;
            }
            TextField {
                id: stationLocationInput
                width: parent.width
                label: qsTr("Location")
                errorHighlight: false
                placeholderText: qsTr("location")
                inputMethodHints: Qt.ImhPreferUppercase
                EnterKey.onClicked: stationCountryInput.focus = true;
            }
            TextField {
                id: stationCountryInput
                width: parent.width
                label: qsTr("Country")
                errorHighlight: false
                placeholderText: qsTr("country")
                inputMethodHints: Qt.ImhPreferUppercase
                EnterKey.onClicked: parent.focus = true;
                onFocusChanged: {
                    if(stationInput.text.length < 0) {
                       stationInput.errorHighlight = true
                    }
                    if(stationNameInput.text.length < 0) {
                       stationNameInput.errorHighlight = true
                    }
                    if(stationNameInput.text.length < 0) {
                       stationNameInput.errorHighlight = true
                    }
                    if(stationLocationInput.text.length < 0) {
                       stationLocationInput.errorHighlight = true
                    }
                    if(stationCountryInput.text.length < 0) {
                       stationCountryInput.errorHighlight = true
                    }

                    deactivateAccept = true
                }
            }

        }

    }

    allowedOrientations: defaultAllowedOrientations
    VerticalScrollDecorator {
        flickable: pageFlickable
    }
    onAccepted:{
      loadManualDataToStorage(stationInput.text, stationNameInput.text, stationLocationInput.text, stationCountryInput.text)
    }
}

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
                EnterKey.onClicked: parent.focus = true;
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
                x: Theme.paddingLarge
            }
            Label {
                id: stationIcao
                width: parent.width
                text: "ZZZZ"
                visible: false
                x: Theme.paddingLarge
            }
            Label {
                id: stationName
                width: parent.width
                visible: false
                x: Theme.paddingLarge
            }
            Label {
                id: stationLocation
                width: parent.width
                visible: false
                x: Theme.paddingLarge
            }
            Label {
                id: stationCountry
                width: parent.width
                visible: false
                x: Theme.paddingLarge
            }

        }

    }

    allowedOrientations: defaultAllowedOrientations
    VerticalScrollDecorator {
        flickable: pageFlickable
    }
    onAccepted:{
      loadDataToStorage(stationInput.text)
    }
}

import QtQuick 2.5
import Sailfish.Silica 1.0
import "../js/client.js" as Client

CoverBackground {
    property var stationID: undefined
    property int coverIndex: 0
    property var temperaturText: undefined
    property var humidityText: undefined

    Label {
        id: label
        visible: !stationID
        anchors.centerIn: parent
        text: qsTr("AirMeteo")
    }

    Item {
        visible: (stationID ? true : false)
        width: parent.width - 2*Theme.paddingLarge

        Column {
            x: Theme.paddingLarge
            width: parent.width

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }

            Label {
                text: stationID
                width: parent.width
                truncationMode: TruncationMode.Fade
            }

            Label {
                width: parent.width
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                text: temperaturText + "° C"
                truncationMode: TruncationMode.Fade
            }

            Label {
                width: parent.width
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.secondaryColor
                text: humidityText + "%"
                truncationMode: TruncationMode.Fade
            }


        }
    }


    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-previous"
            onTriggered: {
                coverIndex = coverIndex - 1
                updateData(coverIndex)
            }

        }

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: {
                coverIndex = coverIndex + 1
                updateData(coverIndex)
            }

        }

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                updateMetarsToStorage()
                reloadMetarsData()
            }
        }
    }
    function updateData(index) {
        var metars = metarBank.getMETARS()
        stationID = metars[index].station_id
        temperaturText = metars[index].temp_c
        humidityText = Client.humidity(metars[index].temp_c, metars[index].dewpoint_c)

    }

    Component.onCompleted: {
        updateData(coverIndex)
    }
}

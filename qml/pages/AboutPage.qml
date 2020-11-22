import QtQuick 2.5
import Sailfish.Silica 1.0


Page {
    id: about

   SilicaFlickable {
        id: pageFlickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: about.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("About")
            }

            IconButton {
                 icon.source: "image://theme/icon-m-sailfish"
                 anchors {
                      horizontalCenter: parent.horizontalCenter
                 }
            }
            Label {
                text: qsTr("AirMeteo version: 0.1")
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeMedium
                anchors {
                        horizontalCenter: parent.horizontalCenter
                 }
            }

            Row {
                x: Theme.paddingLarge

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                    text: qsTr("Author:")
                }
            }
            Row {
                x: 50

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: qsTr("bauidch")
                }
            }

            Row {
                x: Theme.paddingLarge

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                    text: qsTr("Data:")
                }
            }
            Row {
                x: 50

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: "aviationweather.gov, airport-data.com"
                }
            }
            Row {
                x: Theme.paddingLarge

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                    text: qsTr("Credits:")
                }
            }
            Row {
                x: 50

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: "harbour-meteoswiss"
                }
            }

        }
   }
   VerticalScrollDecorator { flickable: pageFlickable }
}

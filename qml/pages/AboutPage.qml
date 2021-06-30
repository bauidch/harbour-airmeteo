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
                text: "AirMeteo version: 0.4"
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
                    text: qsTr("Disclaimer:")
                }
            }

            Row {
                x: Theme.paddingLarge
                width: parent.width - 2*x
                spacing: Theme.paddingLarge

                Label {
                    text: qsTr("Not for operational use! The data used on this app could be outdated, inaccurate or contain errors. Always use up-to-date official service from your airport for flight planning.")
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                    width: parent.width
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
                    wrapMode: Text.Wrap
                    text: "aviationweather.gov, airport-data.com, ourairports.com"
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
                    wrapMode: Text.Wrap
                    text: "harbour-meteoswiss, welkweer, harbour-opensensefish"
                }
            }
            Row {
                x: Theme.paddingLarge

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                    text: qsTr("Icons:")
                }
            }
            Row {
                x: 50

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall
                    wrapMode: Text.Wrap
                    text: "There are from lucide.dev"
                }
            }



        }
   }
   VerticalScrollDecorator { flickable: pageFlickable }
}

import QtQuick 2.5
import Sailfish.Silica 1.0
import ".."

Page {
    id: stationPage

    SilicaFlickable {
           anchors.fill: parent

           PullDownMenu {
               MenuItem {
                   text: qsTr("Add to Favorites")
                   //onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
               }
           }

           PushUpMenu {
               MenuItem {
                   text: qsTr("Raw") // dataMode RAW Decoded
                   //onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
               }
           }


    Column {
        id: headerContainer
        width: stationPage.width
        spacing: Theme.paddingSmall

        PageHeader {
            id: pageHeader
            title: "LSZH"
            Label {
                id: subLabel
                text: "Zurich"
                color: Theme.highlightColor
                anchors {
                    right: parent.right
                    rightMargin: Theme.horizontalPageMargin
                    bottom: parent.bottom
                    bottomMargin:  Theme.paddingSmall
                }
                font {
                    pixelSize: Theme.fontSizeExtraSmall
                    family: Theme.fontFamilyHeading
                }
            }
        }


        SectionHeader {
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.secondaryHighlightColor
            text: "METAR"
            wrapMode: Text.Wrap
        }
        Column {
            id: rawMETAR
            x: Theme.paddingLarge
            width: parent.width - 2*x
            spacing: Theme.paddingLarge

            Label {
                text: "LSZH 170850Z VRB02KT 9999 FEW008 BKN060 08/05 Q1018 NOSIG="
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
                width: parent.width

            }
        }

        Row {
            width: parent.width
            spacing: Theme.paddingSmall

            Label {
                width: isPortrait ? parent.width * 0.33 : parent.width * 0.33 / 1.5
                text: "Temperatur"
                horizontalAlignment: Text.AlignRight
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.Wrap
            }

            Label {
                width: isPortrait ? parent.width * 0.66 : parent.width * 0.66 / 1.5
                text: "Foo"
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeMedium
            }
        }

        Label {
            id: metarUpdateTime
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Updatet at 22"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeTiny
        }

        SectionHeader {
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.secondaryHighlightColor
            text: "TAF"
            wrapMode: Text.Wrap
        }
        Column {
            id: rawTAF
            x: Theme.paddingLarge
            width: parent.width - 2*x
            spacing: Theme.paddingLarge

            Label {
                text: "LSZH 170825Z 1709/1815 34004KT 9999 FEW025 BKN060 TX10/1714Z TN05/1805Z TX11/1814Z PROB30  TEMPO 1709/1713 03005KT PROB40 1800/1807 4000 BR"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
                width: parent.width

            }
        }

        Label {
            id: tafUpdateTime
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Updatet at 11"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeTiny
        }

    }
    }
}

import QtQuick 2.5
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import ".."
import "../components"


Page {
    id: stationPage
    property string stationCode

    Component.onCompleted: {
         loadMetar()
    }

    function loadMetar() {
        var metar = metarBank.getMETAR(stationCode)
        rawMETARLabel.text = metar[0].raw_text
        temperatur.valueLabelText =  metar[0].temp_c + " C"
        dewpoint.valueLabelText = metar[0].dewpoint_c + " C"
        windDirection.valueLabelText = metar[0].wind_dir_degrees + " Grad"
        windSpeed.valueLabelText = metar[0].wind_speed_kt + " kt"
        metarUpdateTime.text = qsTr("Update at ") + metar[0].observation_time
        subLabel.text = metar[0].location

    }

    SilicaFlickable {
           anchors.fill: parent

           PullDownMenu {
               MenuItem {
                   text: qsTr("Refresh")
                   //onClicked: loadDataToStorage(stationCode)
               }
           }

           PushUpMenu {
               MenuItem {
                   text: qsTr("Raw") // dataMode RAW Decoded
                   //onClicked: test_airdata.getMETAR("LSZH")
               }
           }


    Column {
        id: headerContainer
        width: stationPage.width
        spacing: Theme.paddingSmall

        PageHeader {
            id: pageHeader
            title: stationCode
            Label {
                id: subLabel
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
                id: rawMETARLabel
                text: "LSZH 170850Z VRB02KT 9999 FEW008 BKN060 08/05 Q1018 NOSIG="
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
                width: parent.width

            }
        }

        AirDataIteam {
            id: temperatur
            typeLabelText: qsTr("Temperatur")
        }

        AirDataIteam {
            id: dewpoint
            typeLabelText: qsTr("Dewpoint")
        }
        AirDataIteam {
            id: windDirection
            typeLabelText: qsTr("Wind Direction")
        }
        AirDataIteam {
            id: windSpeed
            typeLabelText: qsTr("Wind Speed")
        }

        Label {
            id: metarUpdateTime
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Updatet at"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeTiny
        }

    }

    }

}

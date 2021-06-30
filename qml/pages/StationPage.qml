import QtQuick 2.5
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import ".."
import "../components"
import "../js/client.js" as Client


Page {
    id: stationPage
    property string stationCode

    Component.onCompleted: {
         loadMetar()
    }

    function loadMetar() {
        var metar = metarBank.getMETAR(stationCode)
        rawMETARLabel.text = metar[0].raw_text

        try {
            var pressureRex = /Q([0-9]{3,4})/
            var pressureValue = pressureRex.exec(metar[0].raw_text)

            presure.valueLabelText = pressureValue[1] + " hPa"
        } catch(e) {
             presure.valueLabelText = "error"
        }

        try {
            var visibilityRex =  /\b(CAVOK|[PM]?([0-9]{4})|([0-9] )?([0-9]{1,2})([0-9])?(SM|KM))\b/
            var visibilityValue = visibilityRex.exec(metar[0].raw_text)
            if (visibilityValue[1] === "9999")
                visibilityValue = qsTr("10 km and more")
            else if (visibilityValue[1] === "CAVOK")
                visibilityValue = qsTr("Clouds and Visibility OK")
            else
                visibilityValue = visibilityValue[1] + " km"
        } catch(error) {
            visibilityValue = "error"
        }
        view.valueLabelText = visibilityValue
        temperatur.valueLabelText =  metar[0].temp_c + "° C"
        dewpoint.valueLabelText = metar[0].dewpoint_c + "° C"
        humidity.valueLabelText = Client.humidity(metar[0].temp_c, metar[0].dewpoint_c) + "%"
        wind.valueLabelText = metar[0].wind_dir_degrees + qsTr("° with ") + metar[0].wind_speed_kt + " kt"

        metarUpdateTime.text = qsTr("Updated at ") + metar[0].observation_time
        subLabel.text = metar[0].location + ", " + metar[0].country

    }

    SilicaFlickable {
           anchors.fill: parent

           PullDownMenu {
               MenuItem {
                   text: qsTr("Refresh")
                   onClicked: {
                       updateMetarsToStorage()
                       reloadMetarsData()
                       loadMetar()
                   }
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
            text: qsTr("RAW")
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
        SectionHeader {
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.secondaryHighlightColor
            text: qsTr("Decoded")
            wrapMode: Text.Wrap
        }

        AirDataIteam {
            id: view
            typeLabelText: qsTr("Visibility")
        }
        AirDataIteam {
            id: wind
            typeLabelText: qsTr("Wind")
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
            id: humidity
            typeLabelText: qsTr("Humidity")
        }
        AirDataIteam {
            id: presure
            typeLabelText: qsTr("Air Presure")
        }


        Label {
            id: metarUpdateTime
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Updatedt at"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeTiny
        }

    }

    }

}

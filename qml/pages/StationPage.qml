import QtQuick 2.5
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import ".."
import "../components"


Page {
    id: stationPage
    property string stationCode

    SilicaFlickable {
           anchors.fill: parent

           PullDownMenu {
               MenuItem {
                   text: qsTr("Refresh")
                   onClicked: loadDataToStorage(stationCode)
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
            text: "Updatet at 22"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeTiny
        }

    }

    Component.onCompleted {
        loadMetar()
    }

    function loadMetar() {
        var metar = metarBank.getMETAR(stationCode)

    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));

            importModule('airdata', function () {
                python.call('airdata.getMetar', [stationCode], function(result) {
                    if (result.length <= 0) {
                       stationPage.noData = "True"
                       console.log('QML Debug: No Data')
                    }

                    for (var i=0; i<result.length; i++) {
                        if (result[i].type === "raw_text") {
                            rawMETARLabel.text =  result[i].value
                        }

                        if (result[i].type === "temp_c") {
                            temperatur.valueLabelText =  result[i].value + " C"
                        }
                        if (result[i].type === "dewpoint_c") {
                            dewpoint.valueLabelText = result[i].value + " C"
                        }
                        if (result[i].type === "wind_dir_degrees") {
                            windDirection.valueLabelText = result[i].value + " Grad"
                        }
                        if (result[i].type === "wind_speed_kt") {
                            windSpeed.valueLabelText = result[i].value + " kt"
                        }

                        if (result[i].type === "observation_time") {
                            metarUpdateTime.text = qsTr("Update at ") + result[i].value
                        }
                    }
                });
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }

    }
    }

}

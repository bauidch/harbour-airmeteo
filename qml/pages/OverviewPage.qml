import QtQuick 2.5
import Sailfish.Silica 1.0
import "../components"
import ".."
import "../js/client.js" as Client

Page {
    id: favoriteList
    allowedOrientations: Orientation.Portrait

    Component.onCompleted: {
        checkForDBMaitanance()
        loadMETARSFromStorageToModel()
        if (metarModel.count === 0 && metarBank.count === 0)
            noStationsPlaceholder.enabled = true
    }

    function moveUP(index) {
        metarModel.move(index, 0, 1)

        var data = []
        for (var i = 0; i < metarModel.count; i++) {
            data.push({ station_id: metarModel.get(i).station_id, view_position: i })

        }
        metarBank.setViewPositions(data)
    }

    SilicaListView {
        id: favoritesView
        model: metarModel
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge
        spacing: Theme.paddingLarge
        delegate: ListItem {
            id: delegateItem
            width: parent.width
            contentHeight: metarbox.height
            menu: contextMenu
            ListView.onRemove: animateRemoval()
            function deleteItem() {
                metarBank.deleteMETAR(model.station_id);
                metarModel.remove(index)
                reloadMetarsData()
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl('StationPage.qml'), {stationCode: model.station_id})
            }

            Rectangle {
                id: metarbox
                color: Theme.rgba(Theme.highlightColor, 0)
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                height: implicitHeight + stationLabel.height + locationLabel.height + temperaturLabel.height + windpositionlabel.height

                Label {
                    id: stationLabel
                    anchors.top: parent.top
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: true
                    text: model.station_id
                    verticalAlignment: Text.AlignBottom
                    height: implicitHeight + Theme.paddingMedium
                }

                Label {
                    id: locationLabel
                    anchors.top: stationLabel.bottom
                    font.pixelSize: Theme.fontSizeTiny
                    color: Theme.secondaryColor
                    text: model.location
                    verticalAlignment: Text.AlignVCenter
                    height: implicitHeight + Theme.paddingSmall
                }

                Label {
                    id: temperaturLabel
                    text: model.temp_c + "° C"
                    color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeLarge

                    anchors {
                        top: parent.top; topMargin: Theme.paddingSmall
                        right: parent.right; rightMargin: Theme.horizontalPageMargin
                    }
                }

                Label {
                    id: humidityLabel
                    text: Client.humidity(model.temp_c, model.dewpoint_c)+ "%"
                    color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeMedium

                    anchors {
                        top: temperaturLabel.bottom; topMargin: Theme.paddingSmall
                        right: parent.right; rightMargin: Theme.horizontalPageMargin
                    }
                }
                Rectangle {
                    id: autoLabel
                    visible: false
                    color: Theme.highlightBackgroundColor
                    anchors {
                        top: humidityLabel.bottom; topMargin: Theme.paddingSmall
                        right: parent.right; rightMargin: Theme.horizontalPageMargin
                    }
                    height: Theme.itemSizeSmall
                    Label {
                       text: "Auto"
                       anchors.centerIn: parent
                    }
                }

                Image {
                    id: windpositionicon
                    source: "../weather-icons/wind-white.png"
                    width: 2*Theme.horizontalPageMargin
                    height: width
                    opacity: 1
                    fillMode: Image.PreserveAspectFit
                    anchors {
                        top: locationLabel.bottom
                        left: parent.left
                    }
                }

                Label {
                    id: windpositionlabel
                    anchors {
                        verticalCenter: windpositionicon.verticalCenter
                        left: windpositionicon.right
                        leftMargin: 0
                    }
                    font.pixelSize: Theme.fontSizeSmall
                    text: model.wind_dir_degrees + qsTr("° with ") + model.wind_speed_kt + " kt"
                    color: Theme.secondaryColor
                    verticalAlignment: Text.AlignVCenter
                    truncationMode: TruncationMode.Fade
                }



            }
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: Theme.rgba(Theme.secondaryColor, 0.05) }
                }
            }

            Component {
                id: contextMenu
                ContextMenu {
                    MenuItem {
                        text: qsTr("Move Up")
                        visible: model.index !== 0
                        onClicked: moveUP(model.index)
                    }
                    MenuItem {
                        text: qsTr("Remove")
                        onClicked: remorseAction(qsTr("Removing"), delegateItem.deleteItem )
                    }
                }
            }
        }

        VerticalScrollDecorator {}


        ViewPlaceholder {
            id: noStationsPlaceholder
            enabled: false
            text: qsTr("No Stations yet")
            hintText: qsTr("Pull down to add stations")

        }

        header: PageHeader {
            title: "AirMeteo"
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Add Station")
                onClicked: pageStack.push(Qt.resolvedUrl("../dialogs/AddStationDialog.qml"))
            }
            MenuItem {
                text: qsTr("Refresh Data")
                onClicked: {
                    updateMetarsToStorage()
                    reloadMetarsData()
                }

            }
        }
    }
}

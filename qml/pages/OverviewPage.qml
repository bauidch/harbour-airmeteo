import QtQuick 2.5
import Sailfish.Silica 1.0
import "../components"
import ".."

Page {
    id: favoriteList
    allowedOrientations: Orientation.Portrait

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
                height: implicitHeight + stationLabel.height + locationLabel.height + temperaturLabel.height + boxpositionlabel.height

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
                    anchors.top: locationLabel.bottom
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                    text: model.temp_c + "° C"
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    height: implicitHeight + Theme.paddingMedium
                }
                Image {
                    id: boxpositionicon
                    source: "image://theme/icon-s-task"
                    anchors {
                        top: temperaturLabel.bottom
                        left: parent.left
                        leftMargin: Theme.horizontalPageMargin
                    }
                }

                Label {
                    id: boxpositionlabel
                    anchors {
                        verticalCenter: boxpositionicon.verticalCenter
                        left: boxpositionicon.right
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
                        text: qsTr("Remove")
                        onClicked: remorseAction(qsTr("Removing"), delegateItem.deleteItem )
                    }
                }
            }
        }

        VerticalScrollDecorator {}


        ViewPlaceholder {
            enabled: metarModel.count === 0
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
                onClicked: updateMetarsToStorage()
            }
        }
    }
}

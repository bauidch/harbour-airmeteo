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
        delegate: ListItem {
            id: delegateItem
            width: parent.width
            menu: contextMenu
            ListView.onRemove: animateRemoval()
            function deleteItem() {
                metarBank.deleteMETARS(model.station_id);
                metarModel.remove(index)
                reloadMetarsData()
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl('StationPage.qml'), {stationCode: model.station_id})
            }

            Label {
                id: typeLabel
                text: model.station_id
                anchors.verticalCenter: parent.verticalCenter
                color: delegateItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                x: Theme.paddingLarge
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
        anchors.fill: parent

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
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsePage.qml"))
            }
            MenuItem {
                text: qsTr("Add Station")
                onClicked: pageStack.push(Qt.resolvedUrl("../dialogs/AddStationDialog.qml"))
            }
            MenuItem {
                text: qsTr("Station")
                onClicked: pageStack.push(Qt.resolvedUrl("StationPage.qml"))
            }
            MenuItem {
                text: qsTr("Refresh Data")
                //onClicked: favoritesBank.addItem(stationPage.stationIcaoId)
            }
        }
    }
}

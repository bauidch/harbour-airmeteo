import QtQuick 2.5
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("AirMeteo")
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"

        }

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: updateMetarsToStorage()
        }
    }
}

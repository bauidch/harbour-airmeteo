import QtQuick 2.5
import Sailfish.Silica 1.0

Row {
    property alias typeLabelText: typeLabel.text
    property alias valueLabelText: valueLabel.text

    width: parent.width
    spacing: Theme.paddingSmall

    Label {
        width: isPortrait ? parent.width * 0.33 : parent.width * 0.33 / 1.5
        id: typeLabel
        horizontalAlignment: Text.AlignRight
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeMedium
        wrapMode: Text.Wrap
    }

    Label {
        width: isPortrait ? parent.width * 0.66 : parent.width * 0.66 / 1.5
        id: valueLabel
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeMedium
    }
}

import QtQuick 2.5
import Sailfish.Silica 1.0
import "pages"
import "components"

ApplicationWindow
{
    initialPage: Component { OverviewPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    FavoritesBank {
        id: favoritesBank
    }
}

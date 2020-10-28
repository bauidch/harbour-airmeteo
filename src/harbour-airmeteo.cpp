#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include "airdata.h"

int main(int argc, char *argv[])
{
    // Set up qml engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> v(SailfishApp::createView());

    // If you wish to publish your app on the Jolla harbour, follow
    // https://harbour.jolla.com/faq#5.3.0 about naming own QML modules.
    qmlRegisterType<AirData>("ch.bauid.airdata", 1, 0, "AirData");

    // Start the application.
    v->setSource(SailfishApp::pathTo("qml/harbour-airmeteo.qml"));
    v->show();
    return app->exec();
}

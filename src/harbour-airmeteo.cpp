#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>

#include "airdata.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName(QStringLiteral("bauid"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("bauid.ch"));

    qmlRegisterType<AirData>("ch.bauid.airdata", 1, 0, "AirData");

    return SailfishApp::main(argc, argv);
}

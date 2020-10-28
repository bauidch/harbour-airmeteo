#include "airdata.h"

bool AirData::postMessage(const QString &station) {
    qDebug() << "Called the C++ method with" << station;
    return true;
}

QString AirData::getMETAR(const QString &station) {
    //QString str = "Hello";
    QNetworkRequest newRequest("https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&stationString=" + station + "&hoursBeforeNow=1&format=xml&mostRecent=true");
    networkManager.get(newRequest);
    connect(&networkManager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(handleNetworkData(QNetworkReply*)));
    return station;
}

void AirData::handleNetworkData(QNetworkReply *networkReply)
{
    QUrl url = networkReply->url();
    if (!networkReply->error()) {
        QString response = QString::fromLatin1(networkReply->readAll());
        qDebug() << response;
        response = response.replace("bgcolor=\"#99CCFF\"","");
        qDebug() << setHtml(response);
    }

    networkReply->deleteLater();
}


const QString AirData :: html ( ) const {
    return s_html;
}

void AirData::setHtml(const QString &newHtml)
{
    s_html = newHtml;
    emit htmlChanged ();
}

void AirData::refresh() {
    qDebug() << "Called the C++ slot";
}

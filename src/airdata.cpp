#include "airdata.h"

bool AirData::postMessage(const QString &station) {
    qDebug() << "Called the C++ method with" << station;
    return true;
}

QString AirData::getMETAR(const QString &station) {
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

        QXmlStreamReader xml(response);
        while (!xml.atEnd() && !xml.hasError())
        {
            xml.readNext();
            if (xml.isStartElement() && (xml.name() == "raw_text")) {
                qDebug() <<  xml.readElementText();
            }
            if (xml.isStartElement() && (xml.name() == "station_id")) {
                qDebug() <<  xml.readElementText();
                ICAOCode = xml.readElementText();
            }
            if (xml.isStartElement() && (xml.name() == "observation_time")) {
                qDebug() <<  xml.readElementText();
            }
            if (xml.isStartElement() && (xml.name() == "temp_c")) {
                qDebug() <<  xml.readElementText();
            }
            if (xml.isStartElement() && (xml.name() == "dewpoint_c")) {
                qDebug() <<  xml.readElementText();
            }
        }
    }

    networkReply->deleteLater();
}

void AirData::refresh() {
    qDebug() << "Called the C++ slot";
}

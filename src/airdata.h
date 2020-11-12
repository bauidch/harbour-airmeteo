#ifndef AIRDATA_H
#include <QObject>

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include <QQmlEngine>
#include <QXmlStreamReader>
#define AIRDATA_H

class AirData: public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE bool postMessage(const QString &station);
    Q_INVOKABLE QString getMETAR(const QString &station);


public slots:
    void refresh();
    void handleNetworkData(QNetworkReply *networkReply);

private:
    QNetworkAccessManager networkManager;
    QString ICAOCode;

};

#endif // AIRDATA_H

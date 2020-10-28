#ifndef AIRDATA_H
#include <QObject>

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#define AIRDATA_H

class AirData: public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE bool postMessage(const QString &station);
    Q_INVOKABLE QString getMETAR(const QString &station);
    Q_PROPERTY(QString html   READ html   WRITE setHtml   NOTIFY htmlChanged)
    const QString html ( ) const;
    void setHtml(const QString &newHtml);

public slots:
    void refresh();
    void handleNetworkData(QNetworkReply *networkReply);

private:
    QNetworkAccessManager networkManager;
    QString s_html;

signals:
    void htmlChanged();

};

#endif // AIRDATA_H

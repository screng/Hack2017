#ifndef CON_MAIN_H
#define CON_MAIN_H

#include <QObject>
#include <QUrl>
#include <QDebug>
#include <QDesktopServices>
#include <QTimer>
#include <QTime>
#include <QFile>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

class con_main : public QObject
{
    Q_OBJECT
public:
    explicit con_main(QObject *objToQML = 0, QObject *parent = 0);

signals:

public slots:

private slots:
    void setStatusOnServer(bool);

    void receivedNetworkReplyGetFile(QNetworkReply*);
    void receivedNetworkReplyStartStop(QNetworkReply*);

    void getFileFromServer();
    void getFileFromServer_local();

    void calcCountdown();

    void setValuesToDefault();

private:

    //parse the json file from sever
    void parseFileFromServer(QString);

    //network manager to get new files from the server
    QNetworkAccessManager networkManagerGetFile;
    QNetworkAccessManager networkManagerStartStop;
    QNetworkReply *nReplyGetFile;
    QNetworkReply *nReplyStartStop;

    //object to QML
    QObject *objectToQML;
    //object to set the time
    QObject *objTimer;
    //objects to set the status of the quests
    QObject *objQ1;
    QObject *objQ2;
    QObject *objQ3;
    QObject *objQ4;
    QObject *objQ5;

    //objects to set the characters active
    QObject *objC1;
    QObject *objC2;
    QObject *objC3;
    QObject *objC4;

    //sets the time limit for the game
    QTimer *tTimer;
    //counts down the time limit for the game
    QTime tTime;

    //timer to get new values from server frequently
    QTimer *tTimerToGetNewFile;

};

#endif // CON_MAIN_H

#include "con_main.h"

con_main::con_main(QObject *objToQML_in, QObject *parent) :
    QObject(parent)
{
    qDebug() << "con_main.cpp: handling the constructor";

    tTime.setHMS(1,0,0);
    qDebug() << tTime.toString("hh:mm:ss");

    //create timer to count down the limit
    tTimer = new QTimer(this);
    connect(tTimer,SIGNAL(timeout()),this,SLOT(calcCountdown()));

    //create timer to get new values from server
    tTimerToGetNewFile = new QTimer(this);
    connect(tTimerToGetNewFile,SIGNAL(timeout()),this,SLOT(getFileFromServer()));

    //connect the network manager
    connect(&networkManagerGetFile,SIGNAL(finished(QNetworkReply*)),this,SLOT(receivedNetworkReplyGetFile(QNetworkReply*)));
    connect(&networkManagerStartStop,SIGNAL(finished(QNetworkReply*)),this,SLOT(receivedNetworkReplyStartStop(QNetworkReply*)));

    objectToQML = objToQML_in;

    QObject *objButtonStart = objectToQML->findChild<QObject*>("buttonstart");

    if(objButtonStart) {
        qDebug() << "con_main.cpp: found object to buttonstart";
        connect(objButtonStart,SIGNAL(clicked(bool)),this,SLOT(setStatusOnServer(bool)));
    }

    QObject *objButtonReset = objectToQML->findChild<QObject*>("buttonreset");

    if(objButtonReset) {
        qDebug() << "con_main.cpp: found object to buttonreset";
        connect(objButtonReset,SIGNAL(clicked()),this,SLOT(setValuesToDefault()));
    }

    objTimer = objectToQML->findChild<QObject*>("timer");
    if(objTimer) {
        qDebug() << "con_main.cpp: found object to timer";
    }

    objQ1 = objectToQML->findChild<QObject*>("quest1_item");
    if(objQ1) {
        qDebug() << "con_main.cpp: found object to quest1";
    }

    objQ2 = objectToQML->findChild<QObject*>("quest2_item");
    if(objQ2) {
        qDebug() << "con_main.cpp: found object to quest2";
    }

    objQ3 = objectToQML->findChild<QObject*>("quest3_item");
    if(objQ3) {
        qDebug() << "con_main.cpp: found object to quest3";
    }

    objQ4 = objectToQML->findChild<QObject*>("quest4_item");
    if(objQ4) {
        qDebug() << "con_main.cpp: found object to quest4";
    }

    objQ5 = objectToQML->findChild<QObject*>("quest5_item");
    if(objQ5) {
        qDebug() << "con_main.cpp: found object to quest5";
    }

    objC1 = objectToQML->findChild<QObject*>("player1");
    if(objC1) {
        qDebug() << "con_main.cpp: found object to player1";
    }

    objC2 = objectToQML->findChild<QObject*>("player2");
    if(objC2) {
        qDebug() << "con_main.cpp: found object to player2";
    }

    objC3 = objectToQML->findChild<QObject*>("player3");
    if(objC3) {
        qDebug() << "con_main.cpp: found object to player3";
    }

    objC4 = objectToQML->findChild<QObject*>("player4");
    if(objC4) {
        qDebug() << "con_main.cpp: found object to player4";
    }
}

void con_main::setValuesToDefault() {
    qDebug() << "set values to default";


}

void con_main::setStatusOnServer(bool bStatus) {
    qDebug() << "status:" << bStatus;

    QUrl myUrl;

    if(bStatus) {
        myUrl.setUrl("https://chaosunicorn.herokuapp.com/start");
    }
    else {
        myUrl.setUrl("https://chaosunicorn.herokuapp.com/stop");
    }

    QNetworkRequest nRequest;
    nRequest.setUrl(myUrl);

    nReplyStartStop = networkManagerStartStop.get(nRequest);


    if(bStatus) {
        tTimer->start(1000);
        tTimerToGetNewFile->start(1000);
    }
    else {
        tTimer->stop();
        tTimerToGetNewFile->stop();
    }

    objC1->setProperty("player1_status",true);
    objC2->setProperty("player2_status",true);
    objC3->setProperty("player3_status",true);
    objC4->setProperty("player4_status",true);

}

void con_main::calcCountdown() {

    tTime = tTime.addSecs(-1);

    objTimer->setProperty("stringTimer",tTime.toString("hh:mm:ss"));
}

void con_main::getFileFromServer() {
    qDebug() << "get new file";

    QUrl url("https://chaosunicorn.herokuapp.com/state");

    QNetworkRequest nRequest;
    nRequest.setUrl(url);

    nReplyGetFile = networkManagerGetFile.get(nRequest);
}

void con_main::receivedNetworkReplyGetFile(QNetworkReply *nReply) {
    QString strData = (QString) nReply->readAll();

    parseFileFromServer(strData);
}

void con_main::receivedNetworkReplyStartStop(QNetworkReply *nReply) {
    QString strData = (QString) nReply->readAll();

    qDebug() << strData;
}

void con_main::getFileFromServer_local() {

    qDebug() << "get new file";

    QFile qFile;

    qFile.setFileName("//media/sf_vf_geteilterOrdner/state.json");

    if(qFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "file is readable";

        QString strFile = qFile.readAll();
        qFile.close();

        parseFileFromServer(strFile);
    }
}

void con_main::parseFileFromServer(QString strFile) {

    qDebug() << "parse file from server";

    //values to look for
    QString strCurrentState = "currentState";

    QString strValueCurrentState = strFile.mid(strFile.indexOf(strCurrentState) + strCurrentState.length()+2,1);

    qDebug() << strValueCurrentState;

    qDebug() << "set status";

    if(strValueCurrentState == "1")
        objQ1->setProperty("bquest1_status",true);

    if(strValueCurrentState == "2")
        objQ2->setProperty("bquest2_status",true);

    if(strValueCurrentState == "3")
        objQ3->setProperty("bquest3_status",true);

    if(strValueCurrentState == "4")
        objQ4->setProperty("bquest4_status",true);

    if(strValueCurrentState == "5")
        objQ5->setProperty("bquest5_status",true);

}

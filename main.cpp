#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QObject>
#include <QDebug>

#include "con_main.h"
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlComponent component(&engine,QUrl(QStringLiteral("qml/AdminPanelQML/main.qml")));
    QObject *obj = component.create();

    con_main b(obj);

    qDebug() << component.errors();

    return app.exec();
}


//QGuiApplication app(argc, argv);

//QtQuick2ApplicationViewer viewer;
//viewer.setMainQmlFile(QStringLiteral("qml/AdminPanelQML/main.qml"));
//viewer.showExpanded();

//return app.exec();

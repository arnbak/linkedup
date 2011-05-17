#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "authorizer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
	Authorizer auth;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
	viewer.rootContext()->setContextProperty("OAuth", &auth);
    viewer.setMainQmlFile(QLatin1String("qml/linkedup/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

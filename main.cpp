#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "authorizer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
	Authorizer auth;
	auth.authorize();

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/linkedup/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

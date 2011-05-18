#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QGraphicsObject>
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

	QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
	QObject::connect(&auth, SIGNAL(authorized()), rootObject, SIGNAL(authorized()));


	viewer.showExpanded();
    return app.exec();
}

#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QGraphicsObject>
#include "qmlapplicationviewer.h"

#include "authorizer.h"
#include "settings.h"
#include "linkedinapi.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

	/*classes designed for use in qml*/
	Authorizer auth;
	Settings settings;
	LinkedInAPI api;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
	viewer.rootContext()->setContextProperty("OAuth", &auth);
	viewer.rootContext()->setContextProperty("Settings", &settings);
	viewer.rootContext()->setContextProperty("API", &api);
    viewer.setMainQmlFile(QLatin1String("qml/linkedup/main.qml"));

	QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
	QObject::connect(&auth, SIGNAL(authorized()), rootObject, SIGNAL(authorized()));


	viewer.showExpanded();
    return app.exec();
}

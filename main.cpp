#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QGraphicsObject>
#include "qmlapplicationviewer.h"

#include "authorizer.h"
#include "settings.h"
#include "linkedinapi.h"
#include "user.h"
#include "notifier.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

	/*classes designed for use in qml*/
	Authorizer auth;
	Settings settings;
	LinkedInAPI api;
	User user;
	Notifier notifier;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
	viewer.rootContext()->setContextProperty("OAuth", &auth);
	viewer.rootContext()->setContextProperty("Settings", &settings);
	viewer.rootContext()->setContextProperty("API", &api);
	viewer.rootContext()->setContextProperty("User", &user);
	viewer.rootContext()->setContextProperty("Notifier", &notifier);
	viewer.setMainQmlFile(QLatin1String("qml/linkedup/main.qml"));

	QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
	QObject::connect(&auth, SIGNAL(authorized()), rootObject, SIGNAL(authorized()));

#ifdef Q_WS_MAEMO_5
	viewer.showFullScreen();
//	viewer.showExpanded();
#else
	viewer.showExpanded();
#endif
    return app.exec();
}

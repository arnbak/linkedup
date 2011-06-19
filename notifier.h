#ifndef NOTIFIER_H
#define NOTIFIER_H

#include <QObject>
#include <string>
#include <stdlib.h>

class Notifier : public QObject
{
    Q_OBJECT
public:
	explicit Notifier(QObject *parent = 0){}
	Q_INVOKABLE void notify(QString notification){
#ifdef Q_WS_MAEMO_5
		QString s("dbus-send --type=method_call --dest=org.freedesktop.Notifications /org/freedesktop/Notifications org.freedesktop.Notifications.SystemNoteInfoprint string:'"+notification+"'");
		system(s.toStdString().c_str());
#endif
	}
	Q_INVOKABLE void longNotify(QString notification){
#ifdef Q_WS_MAEMO_5
		QString str("dbus-send --type=method_call --dest=org.freedesktop.Notifications /org/freedesktop/Notifications org.freedesktop.Notifications.SystemNoteDialog string:'"+notification+"' uint32:0 string:'OK'");
		system(str.toStdString().c_str());
#endif
	}
	Q_INVOKABLE void minimize(){
#ifdef Q_WS_MAEMO_5
		system("dbus-send --type=signal --session /com/nokia/hildon_desktop com.nokia.hildon_desktop.exit_app_view");
#endif
	}

signals:

public slots:

};

#endif // NOTIFIER_H

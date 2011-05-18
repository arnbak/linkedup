#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
public:
	explicit Settings(QObject *parent = 0){
		settings = new QSettings(QSettings::UserScope, "linkedup", "linkedup");
	}
	~Settings(){delete settings;}

	Q_INVOKABLE QString get(QString value){
		return settings->value(value, "").toString();
	}

	Q_INVOKABLE void set(QString key, QString value){
		settings->setValue(key, value);
	}

private:
	QSettings* settings;

};

#endif // SETTINGS_H

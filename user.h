#ifndef USER_H
#define USER_H

#include <QObject>
#include <QStringList>
#include <QHash>

class User : public QObject
{
    Q_OBJECT
public:
    explicit User(QObject *parent = 0);
	~User();

	Q_INVOKABLE void setCompaniesFollowed(QString xml);
	Q_INVOKABLE bool following(QString id);
	Q_INVOKABLE void follow(QString id, QString name);
	Q_INVOKABLE void stopFollow(QString id);

	Q_INVOKABLE void setPeopleConnections(QString xml);
	Q_INVOKABLE bool connected(QString id);
	Q_INVOKABLE void addConnection(QString id, QString firstName);
	Q_INVOKABLE void removeConnection(QString id);

	void print();


private:
	QHash<QString,QString>* companiesFollowed;
	QHash<QString,QString>* peopleConnections;

};

#endif // USER_H

#ifndef LINKEDINAPI_H
#define LINKEDINAPI_H

#include <QObject>
#include <QStringList>
#include "creds.h"


extern "C" {
#include "oauth.h"
}

class LinkedInAPI : public QObject
{
    Q_OBJECT

public:
    explicit LinkedInAPI(QObject *parent = 0);
	~LinkedInAPI();

	QString api_request(QString url);
	QString api_delete(QString url);
	QStringList api_post(QString url, QString body);
	QStringList api_put(QString url, QString body);

	Q_INVOKABLE QString get_person_current();
	Q_INVOKABLE QString get_person_by_id(QString id);
	Q_INVOKABLE QString get_person_public_by_id(QString id);
	Q_INVOKABLE QString get_person_following_company();
	Q_INVOKABLE QString get_connections_current();
	Q_INVOKABLE QString get_connections_by_id(QString id);
	Q_INVOKABLE QString get_updates_current();
	Q_INVOKABLE QString get_updates_by_id(QString id);
	Q_INVOKABLE QString get_shares_current();
	Q_INVOKABLE QString get_company_by_id(QString id);
	Q_INVOKABLE QString get_company_suggestions();

	Q_INVOKABLE QString search_person(QString search, QString start, QString count);
	Q_INVOKABLE QString search_company(QString search, QString start, QString count);


	Q_INVOKABLE QString delete_company_following(QString id);


	Q_INVOKABLE QStringList put_like(QString networkKey, QString boolean);


	Q_INVOKABLE QStringList post_status(QString status);
	Q_INVOKABLE QStringList post_share(QString status);
	Q_INVOKABLE QStringList post_message(QString id, QString subject, QString message);
	Q_INVOKABLE QStringList post_invitation(QString email, QString firstName, QString lastName, QString subjectBody, QString message);
	Q_INVOKABLE QStringList post_comment(QString networkKey, QString comment);
	Q_INVOKABLE QStringList post_company_follow(QString id);

	QString generate_header(char* params);


};

#endif // LINKEDINAPI_H

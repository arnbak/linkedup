#ifndef LINKEDINAPI_H
#define LINKEDINAPI_H

#include <QObject>
#include "creds.h"

extern "C" {
#include <oauth.h>
}

class LinkedInAPI : public QObject
{
    Q_OBJECT
public:
    explicit LinkedInAPI(QObject *parent = 0);
	~LinkedInAPI();

	QString api_request(QString url);
	QString api_post(QString url, QString body);

	Q_INVOKABLE QString get_person_current();
	Q_INVOKABLE QString get_person_by_id(QString id);
	Q_INVOKABLE QString search_person(QString type, QString search);
	Q_INVOKABLE void post_status(QString status);
	Q_INVOKABLE void post_message(QString subject, QString message);

	QString generate_header(char* params);


};

#endif // LINKEDINAPI_H

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


	Q_INVOKABLE QString get_person_current();
	Q_INVOKABLE QString get_person_by_id();
	Q_INVOKABLE bool post_status(QString status);


};

#endif // LINKEDINAPI_H

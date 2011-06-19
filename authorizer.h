#ifndef AUTHORIZER_H
#define AUTHORIZER_H

#include <QObject>
#include "creds.h"

extern "C" {
#include "oauth.h"
}

class Authorizer : public QObject
{
    Q_OBJECT
public:
    explicit Authorizer(QObject *parent = 0);
	virtual ~Authorizer();

	Q_INVOKABLE	QString request_token();
	Q_INVOKABLE void generate_access_url(QString request_response);

	Q_INVOKABLE	QString access_token(QString pin);
	Q_INVOKABLE void store_key(QString request_response);

private:
	QString* req_token;
	QString* req_secret;
	QString* signed_url;

signals:
	void authorized();
};

#endif // AUTHORIZER_H

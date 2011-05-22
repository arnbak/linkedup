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

	Q_INVOKABLE	void request_token();
	Q_INVOKABLE	void access_token(QString pin);

private:
	QString* req_token;
	QString* req_secret;
	QString* signed_url;

signals:
	void authorized();
};

#endif // AUTHORIZER_H

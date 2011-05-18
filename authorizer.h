#ifndef AUTHORIZER_H
#define AUTHORIZER_H

#define REQUEST_URL		"https://api.linkedin.com/uas/oauth/requestToken"
#define AUTHORIZE_URL	"https://api.linkedin.com/uas/oauth/authorize?"
#define ACCESS_URL		"https://api.linkedin.com/uas/oauth/accessToken"
#define CONSUMER_KEY	"1ejKUGGYcdJ9Ya3YY3GUTPTB6BFpbTyMYFfQ6rfQuqGgoiKOheSwKjeWnI3-sUn5"
#define CONSUMER_SECRET	"GKfu-s_stCb4EHMjoSm9XX0A1hq2QBNNbO2fGQ1ddglwPiwP0LGys4bANIlTvQks"

#include <QObject>

extern "C" {
#include <oauth.h>
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

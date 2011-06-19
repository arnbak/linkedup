#include "authorizer.h"
#include <QUrl>
#include <QDesktopServices>
#include <QSettings>

#include "iostream"
using namespace std;

extern

Authorizer::Authorizer(QObject *parent) :
    QObject(parent)
{
	req_token = 0;
	req_secret = 0;
	signed_url = 0;
}

Authorizer::~Authorizer(){
	delete req_token;
	delete req_secret;
	delete signed_url;
}

QString Authorizer::request_token(){

	//generate request url
	char* req_url = NULL;
	req_url = oauth_sign_url2(REQUEST_URL, NULL, OA_HMAC, "GET", CONSUMER_KEY, CONSUMER_SECRET, NULL, NULL);
	signed_url = new QString(req_url);

//	delete req_url;
	return *signed_url;
}

void Authorizer::generate_access_url(QString reply){
	//create a qurl to parse to token id
	QUrl tmpUrl("https://api.linkedin.com/uas/oauth/authorize?" + QString(reply));
	req_token = new QString(tmpUrl.queryItemValue("oauth_token")); //save token for access
	req_secret = new QString(tmpUrl.queryItemValue("oauth_token_secret")); //save token for access

	QString finalStr("https://api.linkedin.com/uas/oauth/authorize?oauth_token=" + *req_token);

	//launch browser to get users authentication
	QDesktopServices::openUrl(QUrl(finalStr));
}




QString Authorizer::access_token(QString pin){

	if(req_token && req_secret){
		QString accessUrl(ACCESS_URL);
		accessUrl.append("&oauth_verifier=");
		accessUrl.append(pin);
		QString access_request(oauth_sign_url2(accessUrl.toStdString().c_str(),
											   NULL,
											   OA_HMAC,
											   "GET",
											   CONSUMER_KEY,
											   CONSUMER_SECRET,
											   req_token->toStdString().c_str(),
											   req_secret->toStdString().c_str()));

		return access_request;



		QString reply(oauth_http_get2(access_request.toStdString().c_str(), NULL, NULL));
		QUrl tmpUrl("https://api.linkedin.com/uas/oauth/authorize?" + reply);

		QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
		settings.setValue("oauth_token", tmpUrl.queryItemValue("oauth_token"));
		settings.setValue("oauth_token_secret", tmpUrl.queryItemValue("oauth_token_secret"));

		delete req_token;
		req_token = 0;
		delete req_secret;
		req_secret = 0;
		emit authorized();
	}


}

void Authorizer::store_key(QString reply){
	cout << "asdfasdf" << endl;

	QUrl tmpUrl("https://api.linkedin.com/uas/oauth/authorize?" + reply);

	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	settings.setValue("oauth_token", tmpUrl.queryItemValue("oauth_token"));
	settings.setValue("oauth_token_secret", tmpUrl.queryItemValue("oauth_token_secret"));
	emit authorized();
}

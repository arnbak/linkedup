#include "authorizer.h"
#include <QUrl>
#include <QDesktopServices>
#include "iostream"
//#include <stdlib.h>

using namespace std;

extern

Authorizer::Authorizer(QObject *parent) :
    QObject(parent)
{
}

Authorizer::~Authorizer(){

}

void Authorizer::authorize(){

	char *res_t_key    = NULL; //< replied key
	char *res_t_secret = NULL; //< replied secret
	char* args = NULL;



	//generate request url
	char* req_url = NULL;
	req_url = oauth_sign_url2(REQUEST_URL, NULL, OA_HMAC, "GET", CONSUMER_KEY, CONSUMER_SECRET, NULL, NULL);
	cout << "Generated Url: " << req_url << "\n" << endl;

	//make the request
	char* reply;
	reply = oauth_http_get2(req_url, args, NULL);
	cout << "Reply: " << reply << "\n" << endl;

	//create a qurl to parse to token id
	QUrl tmpUrl("https://api.linkedin.com/uas/oauth/authorize?" + QString(reply));
	QString finalStr("https://api.linkedin.com/uas/oauth/authorize?oauth_token=" + tmpUrl.queryItemValue("oauth_token"));

	//launch browser to get users authentication
	QDesktopServices::openUrl(QUrl(finalStr));


}

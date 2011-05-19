#include "linkedinapi.h"
#include <QSettings>
#include <QFile>
#include <QDomDocument>
#include <QUrl>

#include <iostream>
using namespace std;

LinkedInAPI::LinkedInAPI(QObject *parent) :
    QObject(parent)
{
}

LinkedInAPI::~LinkedInAPI(){

}

QString LinkedInAPI::api_request(QString url){
	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2(url.toStdString().c_str(),
								   NULL,
								   OA_HMAC,
								   "GET",
								   CONSUMER_KEY,
								   CONSUMER_SECRET,
								   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
								   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	char* reply = oauth_http_get2(request, NULL, NULL);
	QString return_reply(reply);

	delete reply;
	delete request;
	return return_reply;
}

QString LinkedInAPI::get_person_current(){
	return api_request("http://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,location,summary,specialties,interests,picture-url)");
}

QString LinkedInAPI::get_person_by_id(){

}

QString LinkedInAPI::search_person(QString firstName, QString lastName){
	return api_request("http://api.linkedin.com/v1/people-search:(people:(id,first-name,last-name,profile-url,headline),num-results)");
}

void LinkedInAPI::post_status(QString status){

	/*create the XML that linkedin uses to make the status*/
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("activity");
//	root.setAttribute("locale", "en_US");
	xml.appendChild(root);

	QDomElement content = xml.createElement("content-type");
	QDomText contentText = xml.createTextNode("linkedin-html");
	content.appendChild(contentText);
	root.appendChild(content);

	QDomElement body = xml.createElement("body");
	QDomText bodyText = xml.createTextNode(status);
	body.appendChild(bodyText);
	root.appendChild(body);
	/*end xml*/


	char* return_args = 0;
	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2("https://api.linkedin.com/v1/people/~/person-activities",
										   &return_args,
										   OA_HMAC,
										   "POST",
										   CONSUMER_KEY,
										   CONSUMER_SECRET,
										   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
										   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	QString header = generate_header(return_args);
	char* reply = oauth_http_post2(request, xml.toString().toStdString().c_str(), header.toStdString().c_str());

	cout << "Succesfuly posted" << endl;

	delete request;
	delete return_args;
	delete reply;
}

QString LinkedInAPI::generate_header(char* return_args){

	//dummy url so that the qurl will parse the parameters
	QUrl params(QString("http://www.null.com?" + QString(return_args)));

	QString header;
	header.append("Content-Type: text/xml\n");
	header.append("Host: api.linkedin.com\n");
	header.append("Authorization: OAuth ");
	header.append("oauth_nonce=\"" + params.queryItemValue("oauth_nonce") + "\", ");
	header.append("oauth_signature_method=\"" + params.queryItemValue("oauth_signature_method") + "\", ");
	header.append("oauth_timestamp=\"" + params.queryItemValue("oauth_timestamp") + "\", ");
	header.append("oauth_consumer_key=\"" + params.queryItemValue("oauth_consumer_key") + "\", ");
	header.append("oauth_token=\"" + params.queryItemValue("oauth_token") + "\", ");
	header.append("oauth_signature=\"" + params.queryItemValue("oauth_signature") + "\", ");
	header.append("oauth_version=\"" + params.queryItemValue("oauth_version") + "\"");

	return header;
}

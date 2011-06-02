#include "linkedinapi.h"
#include <QSettings>
#include <QFile>
#include <QDomDocument>
#include <QUrl>
//#include <QNetworkReply>
//#include <QNetworkRequest>

#include <iostream>
using namespace std;

#define NULL 0

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

	QString signed_url(request);
//	cout << request << endl;

	delete request;
	return signed_url;

}

/**
  Returns the components needed to make a POST request
  */
QStringList LinkedInAPI::api_post(QString url, QString body){
	char* return_args = 0;
	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2(url.toStdString().c_str(),
								   &return_args,
								   OA_HMAC,
								   "POST",
								   CONSUMER_KEY,
								   CONSUMER_SECRET,
								   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
								   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	QString header = generate_header(return_args);
	QString signed_url(request);
//	char* reply = oauth_http_post2(request, body.toStdString().c_str(), header.toStdString().c_str());
//	QString return_reply(reply);

//	cout << "Succesfuly posted" << endl;

	delete request;
	delete return_args;
//	delete reply;
//	return return_reply;

	QStringList params;
	params << signed_url << header << body;
	return params;
}


QString LinkedInAPI::get_person_current(){
//	cout << "User profile" << endl;
	return api_request("http://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,industry,location,summary,specialties,interests,picture-url,educations:(id,school-name,start-date,end-date,field-of-study,degree,activities),positions:(id,start-date,end-date,title,summary,company:(name)),skills:(id),recommendations-received:(id,recommendation-type,recommender),honors,associations)");
}

QString LinkedInAPI::get_person_by_id(QString id){
//	cout << "Get person by ID" << endl;
	return api_request("http://api.linkedin.com/v1/people/id="+id+":(id,first-name,last-name,headline,industry,location,summary,specialties,interests,picture-url,educations:(id,school-name,start-date,end-date,field-of-study,degree,activities),positions:(id,start-date,end-date,title,summary,company:(name)),skills:(id),recommendations-received:(id,recommendation-type,recommender),honors,associations)");
}

QString LinkedInAPI::search_person(QString type, QString search){
//	cout << "search" << endl;
	search = QUrl::toPercentEncoding(search);
	return api_request("http://api.linkedin.com/v1/people-search:(people:(id,first-name,last-name,picture-url,headline,location,industry),num-results)?count=20&keywords=" + search);
}

QString LinkedInAPI::get_connections_current(){
//	cout << "all connections" << endl;
	return (api_request("http://api.linkedin.com/v1/people/~/connections"));
}

QString LinkedInAPI::get_updates_current(){
	return (api_request("http://api.linkedin.com/v1/people/~/network/updates?type=CONN&count=50"));
}

QStringList LinkedInAPI::post_status(QString status){

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

	return api_post("https://api.linkedin.com/v1/people/~/person-activities", xml.toString());

}

QStringList LinkedInAPI::post_message(QString subjectBody, QString message){
	/*create the XML that linkedin uses to make the status*/
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("mailbox-item");
	xml.appendChild(root);

	QDomElement recipients = xml.createElement("recipients");
	root.appendChild(recipients);

	QDomElement recipient = xml.createElement("recipient");
	recipients.appendChild(recipient);

	QDomElement person = xml.createElement("person");
	person.setAttribute("path", "/people/~");
	recipient.appendChild(person);


	QDomElement subject = xml.createElement("subject");
	QDomText subjectText = xml.createTextNode(subjectBody);
	subject.appendChild(subjectText);
	root.appendChild(subject);

	QDomElement body = xml.createElement("body");
	QDomText bodyText = xml.createTextNode(message);
	body.appendChild(bodyText);
	root.appendChild(body);

//	cout << xml.toString().toStdString() << endl;
	return api_post("http://api.linkedin.com/v1/people/~/mailbox", xml.toString());
}

QString LinkedInAPI::generate_header(char* return_args){

	//dummy url so that the qurl will parse the parameters
	QUrl params(QString("http://www.null.com?" + QString(return_args)));

	QString header;
	header.append("OAuth oauth_nonce=\"" + params.queryItemValue("oauth_nonce") + "\", ");
	header.append("oauth_signature_method=\"" + params.queryItemValue("oauth_signature_method") + "\", ");
	header.append("oauth_timestamp=\"" + params.queryItemValue("oauth_timestamp") + "\", ");
	header.append("oauth_consumer_key=\"" + params.queryItemValue("oauth_consumer_key") + "\", ");
	header.append("oauth_token=\"" + params.queryItemValue("oauth_token") + "\", ");
	header.append("oauth_signature=\"" + params.queryItemValue("oauth_signature") + "\", ");
	header.append("oauth_version=\"" + params.queryItemValue("oauth_version") + "\"");

	return header;
}

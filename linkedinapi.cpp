#include "linkedinapi.h"
#include <QSettings>
#include <QFile>
#include <QDomDocument>
#include <QUrl>

#include <iostream>
using namespace std;

#define NULL 0

/**
  This class is used for creating signed urls that are OAuth compliant.
  No requests are made; urls, headers and bodies are returned to be requested
  in the QML code using Javascript.
  */

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

	delete request;
	return signed_url;

}


QString LinkedInAPI::api_delete(QString url){

	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2(url.toStdString().c_str(),
								   NULL,
								   OA_HMAC,
									"Delete",
								   CONSUMER_KEY,
								   CONSUMER_SECRET,
								   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
								   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	QString signed_url(request);

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

	delete request;
	delete return_args;

	QStringList params;
	params << signed_url << header << body;
	return params;
}

QStringList LinkedInAPI::api_put(QString url, QString body){
	char* return_args = 0;
	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2(url.toStdString().c_str(),
								   &return_args,
								   OA_HMAC,
								   "PUT",
								   CONSUMER_KEY,
								   CONSUMER_SECRET,
								   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
								   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	QString header = generate_header(return_args);
	QString signed_url(request);

	delete request;
	delete return_args;

	QStringList params;
	params << signed_url << header << body;
	return params;
}

/**
  Get the profile of the user. This is equivalant to
  calling get_person_by_id("~").
  @return The signed url from liboauth to use when requesting the profile xml
  */
QString LinkedInAPI::get_person_current(){
	return api_request("http://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,industry,location,summary,specialties,interests,picture-url,educations:(id,school-name,start-date,end-date,field-of-study,degree,activities),positions:(id,start-date,end-date,title,summary,company:(name)),skills:(id),recommendations-received:(id,recommendation-type,recommender),honors,associations)");
}

/**
  Get the profile of a person by their id.
  @param id The id of the member's profile
  @return The signed url from liboauth to use when requesting the profile xml
  */
QString LinkedInAPI::get_person_by_id(QString id){
	return api_request("http://api.linkedin.com/v1/people/id="+id+":(id,first-name,last-name,headline,industry,location,summary,specialties,interests,picture-url,educations:(id,school-name,start-date,end-date,field-of-study,degree,activities),positions:(id,start-date,end-date,title,summary,company:(name)),skills:(id),recommendations-received:(id,recommendation-type,recommender),honors,associations)");
}

/**
  Get the public profile of a person by their id.
  This should be used to get a reduced amount of information
  about a member when they are outside of the users network.
  @param id The id of the member's profile
  @return The signed url from liboauth to use when requesting the profile xml
  */
QString LinkedInAPI::get_person_public_by_id(QString id){
	return api_request("http://api.linkedin.com/v1/people/id="+id+":public");
}

/**
  Stop following a company
  @param id The numeric id of the company to stop following, not the name.
  @return The signed url from liboauth to use when requesting the company xml
  */
QString LinkedInAPI::delete_company_following(QString id){
	return api_delete("http://api.linkedin.com/v1/people/~/following/companies/id="+id);
}

/**
  Search for a person
  @param search The search string
  @param start The number of results to start at. ie, if there are 300 search
  results and you want to start at result number 20.
  @param count The number of results to return in total
  @return The url to use when posting a GET for a people search
  */
QString LinkedInAPI::search_person(QString search, QString start, QString count){
	search = QUrl::toPercentEncoding(search);
	return api_request("http://api.linkedin.com/v1/people-search:(people:(id,first-name,last-name,picture-url,headline,location,industry),num-results)?start="+start+"&count="+count+"&keywords=" + search);
}

/**
  Search for a compnay
  @param search The search string
  @param start The number of results to start at. ie, if there are 300 search
  results and you want to start at result number 20.
  @param count The number of results to return in total
  @return The url to use when posting a GET for a company search
  */
QString LinkedInAPI::search_company(QString search,QString start, QString count){
	search = QUrl::toPercentEncoding(search);
	return api_request("http://api.linkedin.com/v1/company-search:(companies:(id,name,universal-name,website-url,logo-url,type),num-results)?start="+start+"&count="+count+"&keywords=" + search);
}

QString LinkedInAPI::get_connections_current(){
	return (api_request("http://api.linkedin.com/v1/people/~/connections"));
}

/**
  Get companies that LinkedIn suggests to the user
  @return sugggested companies
  */
QString LinkedInAPI::get_company_suggestions(){
	return (api_request("http://api.linkedin.com/v1/people/~/suggestions/to-follow/companies"));
}

/**
  Get companies that LinkedIn suggests to the user
  @return sugggested companies
  */
QString LinkedInAPI::get_person_following_company(){
	return (api_request("http://api.linkedin.com/v1/people/~/following/companies"));
}

QString LinkedInAPI::get_connections_by_id(QString id){
	return (api_request("http://api.linkedin.com/v1/people/id="+id+"/connections"));
}

QString LinkedInAPI::get_updates_current(){
	return (api_request("http://api.linkedin.com/v1/people/id=~/network/updates?type=CONN&count=10"));

}

QString LinkedInAPI::get_updates_by_id(QString id){
	return (api_request("http://api.linkedin.com/v1/people/id="+id+"/network/updates?type=SHAR&type=PICT&type=PRFU&count=50"));
}

QString LinkedInAPI::get_shares_current(){
	return (api_request("http://api.linkedin.com/v1/people/~/network/updates?type=SHAR&type=PRFU&count=50"));
}

/**
  Get a company's profile
  @param id The ID that identifies the company
  @return the URL to use as in a GET that returns the company profile XML
  */
QString LinkedInAPI::get_company_by_id(QString id){
	return (api_request("http://api.linkedin.com/v1/companies/"+id+":(id,name,ticker,description,logo-url,square-logo-url,website-url,industry,size,status,specialties,locations)"));
}

QStringList LinkedInAPI::post_status(QString status){

	/*create the XML that linkedin uses to make the status*/
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("activity");
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

/**
  Post a share on behalf of the current user. This appears on their home page and is
  visible to their connections
  @param status The status to be posted
  @return A list containing a signed url, an authorization header, and a body to be PUT
  */
QStringList LinkedInAPI::post_share(QString status){
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("share");
	xml.appendChild(root);

	QDomElement comment = xml.createElement("comment");
	QDomText commentText = xml.createTextNode(status);
	comment.appendChild(commentText);
	root.appendChild(comment);

	QDomElement visibility = xml.createElement("visibility");
	root.appendChild(visibility);

	QDomElement code = xml.createElement("code");
	visibility.appendChild(code);
	QDomText codeText = xml.createTextNode("anyone");
	code.appendChild(codeText);
	visibility.appendChild(code);

	return api_post("https://api.linkedin.com/v1/people/~/shares", xml.toString());
}

/**
  Send a message to a user using POST method
  @param id The numeric id of the user
  @param subjectBody The subject of the message
  @param message The body of the message
  @return QStringList containing the url, authorization header and the POST body
  */
QStringList LinkedInAPI::post_message(QString id, QString subjectBody, QString message){
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
	person.setAttribute("path", "/people/"+id);
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

/**
  Send an invitation to connect with a LinkedIn member
  @param email The email address of the member being invited to connect
  @param firstName The first name of the member being invited to connect
  @param lastName The last name of the member being invited to connect
  @param subjectBody The subject of the message
  @param message The body of the message
  @return QStringList containing the url, authorization header and the POST body
  */
QStringList LinkedInAPI::post_invitation(QString email, QString firstName, QString lastName, QString subjectBody, QString message){
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
	person.setAttribute("path", "/people/email="+email);

	QDomElement personFirst = xml.createElement("first-name");
	personFirst.appendChild(xml.createTextNode(firstName));

	QDomElement personLast = xml.createElement("last-name");
	personLast.appendChild(xml.createTextNode(lastName));

	recipient.appendChild(person);



	QDomElement subject = xml.createElement("subject");
	QDomText subjectText = xml.createTextNode(subjectBody);
	subject.appendChild(subjectText);
	root.appendChild(subject);

	QDomElement body = xml.createElement("body");
	QDomText bodyText = xml.createTextNode(message);
	body.appendChild(bodyText);
	root.appendChild(body);


	QDomElement itemContent = xml.createElement("item-content");
	root.appendChild(itemContent);

	QDomElement invRequest = xml.createElement("invitation-request");
	itemContent.appendChild(invRequest);

	QDomElement connectType = xml.createElement("connect-type");
	connectType.appendChild(xml.createTextNode("friend"));
	itemContent.appendChild(connectType);



//	cout << xml.toString().toStdString() << endl;
	return api_post("http://api.linkedin.com/v1/people/~/mailbox", xml.toString());
}

/**
  Comment on a share
  @param networkKey identifies what is to be commented on
  @param comment The comment to post
  @return A list containing a signed url, an authorization header, and a body to be PUT
  */
QStringList LinkedInAPI::post_comment(QString networkKey, QString comment){
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("update-comment");
	xml.appendChild(root);

	QDomElement commentNode = xml.createElement("comment");
	QDomText commentText = xml.createTextNode(comment);
	commentNode.appendChild(commentText);

	root.appendChild(commentNode);

	return api_post("http://api.linkedin.com/v1/people/~/network/updates/key="+networkKey+"/update-comments", xml.toString());
}

/**
  Start following a company
  @param id The id of the company to follow
  @return A list containing a signed url, an authorization header, and a body to be PUT
  */
QStringList LinkedInAPI::post_company_follow(QString id){
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("company");
	xml.appendChild(root);

	QDomElement node = xml.createElement("id");
	QDomText nodeText = xml.createTextNode(id);
	node.appendChild(nodeText);

	root.appendChild(node);

	return api_post("http://api.linkedin.com/v1/people/~/following/companies", xml.toString());
}

/**
  Like or unlike a share
  @param networkKey identifies what is to be liked / unliked
  @param boolean true if networkKey is to be liked, false for an unlike
  @return A list containing a signed url, an authorization header, and a body to be PUT
  */
QStringList LinkedInAPI::put_like(QString networkKey, QString boolean){
	QDomDocument xml;

	QDomProcessingInstruction pi = xml.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-16\"");
	xml.appendChild(pi);

	QDomElement root = xml.createElement("is-liked");
	QDomText liked = xml.createTextNode(boolean);
	root.appendChild(liked);
	xml.appendChild(root);

	return api_put("http://api.linkedin.com/v1/people/~/network/updates/key="+networkKey+"/is-liked", xml.toString());
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

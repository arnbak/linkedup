#include "linkedinapi.h"
#include <QSettings>

LinkedInAPI::LinkedInAPI(QObject *parent) :
    QObject(parent)
{
}

LinkedInAPI::~LinkedInAPI(){

}


QString LinkedInAPI::get_person_current(){

	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2("http://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,location,summary,specialties,interests,picture-url)",
										   NULL,
										   OA_HMAC,
										   "GET",
										   CONSUMER_KEY,
										   CONSUMER_SECRET,
										   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
										   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	return QString(oauth_http_get2(request, NULL, NULL));
}

QString LinkedInAPI::get_person_by_id(){

}

bool LinkedInAPI::post_status(QString status){

	QString statusPost('<activity locale="en_US">\
					   <content-type>linkedin-html</content-type>\
					   <body>xxxx</body>\
					   </activity>');
	statusPost.replace("xxxx", status);

	QSettings settings(QSettings::UserScope, "linkedup", "linkedup");
	char* request = oauth_sign_url2("http://api.linkedin.com/v1/people/~/person-activities",
										   NULL,
										   OA_HMAC,
										   "POST",
										   CONSUMER_KEY,
										   CONSUMER_SECRET,
										   settings.value("oauth_token", NULL).toString().toStdString().c_str(),
										   settings.value("oauth_token_secret", NULL).toString().toStdString().c_str());

	QString reply(oauth_http_post2(request, NULL, NULL));
	if(reply.contains("201"))
		return true;
	return false;
}

#include "user.h"
#include <QDomDocument>

#include <iostream>
using namespace std;

User::User(QObject *parent) :
    QObject(parent)
{
	companiesFollowed = new QHash<QString,QString>;
	peopleConnections = new QHash<QString,QString>;
}

User::~User(){
	delete companiesFollowed;
	delete peopleConnections;
}

/**
  Sets the companies that the user is following based on an xml file
  obtained from an OAuth reques to http://api.linkedin.com/v1/people/~/following/companies.
  @param xml The xml file that is returned from LinkedIn
  */
void User::setCompaniesFollowed(QString xml){
	companiesFollowed->clear();

	QDomDocument doc;
	doc.setContent(xml);

	QDomNodeList companies = doc.elementsByTagName("company");

	for(int i = 0; i < companies.length(); i++){
		QString key = companies.at(i).namedItem("id").toElement().text();
		QString value = companies.at(i).namedItem("name").toElement().text();
		companiesFollowed->insert(key, value);
	}


}

/**
  Tests to see if the user is following a company
  @param id The numeric id of the company, not the name
  */
bool User::following(QString id){
	return companiesFollowed->contains(id);
}

/**
  Start following a company
  @param id The numeric id of the company
  @param name The name of the company
  */
void User::follow(QString id, QString name){
	companiesFollowed->insert(id, name);
}

/**
  Stop following a company
  @param id The numeric id of the company
  */
void User::stopFollow(QString id){
	companiesFollowed->remove(id);
}

/**
  Sets the people that the user is connected to based on an xml file
  obtained from an OAuth reques to http://api.linkedin.com/v1/people/~/connections.
  @param xml The xml file that is returned from LinkedIn
  */
void User::setPeopleConnections(QString xml){
	peopleConnections->clear();

	QDomDocument doc;
	doc.setContent(xml);

	QDomNodeList people = doc.elementsByTagName("person");

	for(int i = 0; i < people.length(); i++){
		QString key = people.at(i).namedItem("id").toElement().text();
		QString value = people.at(i).namedItem("first-name").toElement().text();
		peopleConnections->insert(key, value);
	}
}

/**
  Tests to see if the user is connected to a member
  @param id The id of the member
  */
bool User::connected(QString id){
	if(id == "~")
		return true;
	return peopleConnections->contains(id);
}

/**
  Add a user connection with another member
  @param id The id of the member
  @param firstName The first name of the member
  */
void User::addConnection(QString id, QString firstName){
	peopleConnections->insert(id, firstName);
}

/**
  Remove a connection with another member
  @param id The id of the member
  */
void User::removeConnection(QString id){
	peopleConnections->remove(id);
}

void User::print(){
	QList<QString> tmpList = peopleConnections->values();
	for(int i = 0; i < tmpList.length(); i++){
		cout << tmpList.at(i).toStdString() << endl;
	}
}

import QtQuick 1.0

XmlListModel{
	id:model
	xml: profileXML
	query: "/person/recommendations-received/recommendation"

	XmlRole {name: "id"; query: "id/string()"}

	XmlRole {name: "recommendationType"; query: "recommendation-type/code/string()"}
	XmlRole {name: "firstName"; query: "recommender/first-name/string()"}
	XmlRole {name: "lastName"; query: "recommender/last-name/string()"}
}

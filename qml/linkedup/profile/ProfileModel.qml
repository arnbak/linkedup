import QtQuick 1.0

XmlListModel{
	id:model
	query: "/person"

	XmlRole {name: "id"; query: "id/string()"}

	XmlRole {name: "firstName"; query: "first-name/string()"}
	XmlRole {name: "lastName"; query: "last-name/string()"}
	XmlRole {name: "pictureUrl"; query: "picture-url/string()"}
	XmlRole {name: "headline"; query: "headline/string()"}
	XmlRole {name: "location"; query: "location/name/string()"}
	XmlRole {name: "specialties"; query: "specialties/string()"}
	XmlRole {name: "interests"; query: "interests/string()"}
	XmlRole {name: "summary"; query: "summary/string()"}
	XmlRole {name: "industry"; query: "industry/string()"}
	XmlRole {name: "honors"; query: "honors/string()"}
	XmlRole {name: "associations"; query: "associations/string()"}

}

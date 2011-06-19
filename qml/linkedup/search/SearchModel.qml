import QtQuick 1.0

XmlListModel{
	id: root

	query: "/people-search/people/person"

	XmlRole { name: "id"; query: "id/string()"; isKey: true}
	XmlRole { name: "firstName"; query: "first-name/string()"; isKey: true }
	XmlRole { name: "lastName"; query: "last-name/string()"; isKey: true }
	XmlRole { name: "pictureUrl"; query: "picture-url/string()"; isKey: true }
	XmlRole { name: "headline"; query: "headline/string()"; isKey: true}
	XmlRole { name: "industry"; query: "industry/string()"; isKey: true}
	XmlRole { name: "location"; query: "location/name/string()"; isKey: true}
	XmlRole { name: "numResults"; query: "num-results/string()"; isKey: true}
}

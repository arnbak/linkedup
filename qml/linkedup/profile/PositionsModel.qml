import QtQuick 1.0

XmlListModel{
	id:model
	xml: profileXML
	query: "/person/positions/position"

	XmlRole {name: "id"; query: "id/string()"}

	XmlRole {name: "title"; query: "title/string()"}
	XmlRole {name: "startDate"; query: "start-date/year/string()"}
	XmlRole {name: "endDate"; query: "end-date/year/string()"}
	XmlRole {name: "summary"; query: "summary/string()"}
	XmlRole {name: "company"; query: "company/name/string()"}
}

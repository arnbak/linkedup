import QtQuick 1.0

XmlListModel{
	id:model
	xml: profileXML
	query: "/person/educations/education"

	XmlRole {name: "id"; query: "id/string()"}

	XmlRole {name: "schoolName"; query: "school-name/string()"}
	XmlRole {name: "startDate"; query: "start-date/year/string()"}
	XmlRole {name: "endDate"; query: "end-date/year/string()"}
	XmlRole {name: "fieldOfStudy"; query: "field-of-study/string()"}
	XmlRole {name: "location"; query: "location/name/string()"}
	XmlRole {name: "degree"; query: "degree/string()"}
	XmlRole {name: "activities"; query: "activities/string()"}
	XmlRole {name: "summary"; query: "summary/string()"}
	XmlRole {name: "industry"; query: "industry/string()"}

}

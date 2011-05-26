import QtQuick 1.0

XmlListModel{
	id: root

	query: "/person/positions"

	XmlRole { name: "summary"; query: "position/summary/string()"; isKey: true}
	XmlRole { name: "title"; query: "position/title/string()"; isKey: true}
	XmlRole { name: "companyName"; query: "position/company/name/string()"; isKey: true}

}





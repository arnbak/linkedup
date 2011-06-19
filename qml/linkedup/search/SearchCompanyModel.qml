import QtQuick 1.0

XmlListModel{
	id: root

	query: "/company-search/companies/company"

	XmlRole { name: "id"; query: "id/string()"; isKey: true}
	XmlRole { name: "name"; query: "name/string()"; isKey: true }
	XmlRole { name: "universalName"; query: "universal-name/string()"; isKey: true }
	XmlRole { name: "websiteUrl"; query: "website-url/string()"; isKey: true }
	XmlRole { name: "logoUrl"; query: "logo-url/string()"; isKey: true}
	XmlRole { name: "industry"; query: "type/string()"; isKey: true}
	XmlRole { name: "numResults"; query: "num-results/string()"; isKey: true}
}

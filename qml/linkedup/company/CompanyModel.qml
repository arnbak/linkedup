import QtQuick 1.0

XmlListModel{
	id: root

	query: "/company"

	XmlRole { name: "id"; query: "id/string()"; isKey: true}
	XmlRole { name: "name"; query: "name/string()"; isKey: true }
	XmlRole { name: "description"; query: "description/string()"; isKey: true}

	XmlRole { name: "ticker"; query: "ticker/string()"; isKey: true }
	XmlRole { name: "websiteUrl"; query: "website-url/string()"; isKey: true }
	XmlRole { name: "logoUrl"; query: "logo-url/string()"; isKey: true}
	XmlRole { name: "industry"; query: "industry/string()"; isKey: true}
	XmlRole { name: "size"; query: "size/string()"; isKey: true}

	XmlRole { name: "logo"; query: "logo-url/string()"; isKey: true}
	XmlRole { name: "squareLogo"; query: "square-logo/string()"; isKey: true}

	XmlRole { name: "status"; query: "status/name/string()"; isKey: true}
}

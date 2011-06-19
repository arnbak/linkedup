import QtQuick 1.0

XmlListModel{
	id: root

	query: "/company/locations/location"

	XmlRole { name: "street1"; query: "address/street1/string()"; isKey: true }
	XmlRole { name: "street2"; query: "address/street2/string()"; isKey: true }
	XmlRole { name: "city"; query: "address/city/string()"; isKey: true }

	XmlRole { name: "postalCode"; query: "address/postal-code/string()"; isKey: true }
	XmlRole { name: "phone"; query: "contact-info/phone1/string()"; isKey: true }


}

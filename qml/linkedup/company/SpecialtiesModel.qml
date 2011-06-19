import QtQuick 1.0

XmlListModel{
	id: root

	query: "/company/specialties/specialty"

	XmlRole { name: "specialty"; query: "string()"; isKey: true }

}

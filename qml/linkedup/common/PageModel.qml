import QtQuick 1.0

XmlListModel{
	id: root

	XmlRole { name: "numResults"; query: "@total/string()"; isKey: true}
}

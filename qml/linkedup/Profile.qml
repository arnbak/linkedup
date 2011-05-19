import QtQuick 1.0

Rectangle {
//	width: 800; height: 480
	width: parent.width; height: parent.height

	property string profileXML: API.get_person_current()

	XmlListModel{
		id:model
		xml: profileXML
		query: "/person"

		XmlRole {name: "firstName"; query: "first-name/string()"}
		XmlRole {name: "lastName"; query: "last-name/string()"}
		XmlRole {name: "pictureUrl"; query: "picture-url/string()"}
	}

	ListView{
		model: model
		anchors.fill: parent
		delegate: ProfileDelegate{}
	}
}

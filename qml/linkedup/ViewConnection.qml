import QtQuick 1.0
import "viewConnection"

Rectangle {
	id: root
//	width: 800; height: 480
	width: parent.width; height: parent.height

	property alias xml: model.xml


	XmlListModel{
		id:model
		query: "/person"
		onXmlChanged: list.model.reload()

		XmlRole {name: "id"; query: "id/string()"}
		XmlRole {name: "firstName"; query: "first-name/string()"}
		XmlRole {name: "lastName"; query: "last-name/string()"}
		XmlRole {name: "headline"; query: "headline/string()"}
		XmlRole {name: "pictureUrl"; query: "picture-url/string()"}
		XmlRole {name: "city"; query: "location/name/string()"}
		XmlRole {name: "country"; query: "location/country/code/string()"}
	}

	ListView{
		id: list
		model: model
		anchors.fill: parent
		delegate: ViewConnectionDelegate{}
	}

}

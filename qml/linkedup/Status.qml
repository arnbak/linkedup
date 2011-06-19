import QtQuick 1.0
import "status"
import "common"

Item {
	id: root
	width: parent.width; height: list.height


	onProfileIDChanged: {
		get(API.get_person_by_id(profileID))
	}

	function get(url){
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4)
				profileXML = xmlHttp.responseText;
		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}


	property string profileID
	property string profileXML
	property alias shown: button.state
	signal posted

	SystemPalette{id: palette}

	XmlListModel{
		id:model
		query: "/person"
		xml: profileXML

		onSourceChanged: {
			if(model.status == XmlListModel.Ready)
				console.log(model.source)
		}

		XmlRole {name: "firstName"; query: "first-name/string()"}
		XmlRole {name: "lastName"; query: "last-name/string()"}
		XmlRole {name: "pictureUrl"; query: "picture-url/string()"}
	}

	RotatingButton{
		id: button
		width: 50
		anchors.bottom: list.top
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Rectangle{
		id: background
		anchors.fill: list
		z: -1
		color:  palette.dark
	}

	ListView{
		id: list
		model: model
		height: 150
		anchors.left: parent.left
		anchors.right: parent.right
		interactive: false
		delegate: StatusDelegate{
			Connections{
				onPosted: root.posted()
			}
		}
		Behavior on y{ PropertyAnimation{target: list; property: "y"; easing.type: Easing.OutExpo; duration: 500} }

	}

	states: [
		State {
			name: "hidden"
			when:  button.state !== ""
			PropertyChanges {target: list; y: list.height}
		}
	]
}

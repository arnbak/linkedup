import QtQuick 1.0
import "newConnections"
import "components"

Window {
	id: root
	busy: true
	borderTitle: "New Connections"


	Component.onCompleted: {
		get(API.get_updates_current())
	}

	function get(url){
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				model.xml = xmlHttp.responseText;
				root.busy = false
			}


		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}


	ListView{
		id: list
		clip: true
		spacing: 20
		anchors.fill: parent
		anchors.topMargin: borderHeight
		model:  model
		delegate: NewConnectionsDelegate{
			onClicked: {
				var comp = Qt.createComponent("Profile.qml")
				var object = comp.createObject(root.parent)
				object.profileID = profileID
				object.caller = root
				root.state = "hidden"
			}

		}
	}


	NewConnectionsModel{
		id: model
	}
}

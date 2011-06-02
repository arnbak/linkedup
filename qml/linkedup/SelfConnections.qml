import QtQuick 1.0
import "selfConnections"
import "components"

Window {
	id: root
	busy: true
	borderTitle: "Connections"
	signal clicked(string xml)

	Component.onCompleted: {
		get(API.get_connections_current())
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
		spacing: 10
		anchors.fill: parent
		anchors.topMargin: borderHeight
		model:  model
		delegate: SelfConnectionsDelegate{
			onClicked: {
				var comp = Qt.createComponent("Profile.qml")
				var object = comp.createObject(root.parent)
				object.profileID = id
				object.caller = root
				root.state = "hidden"
			}
		}
	}


	SelfConnectionsModel{
		id: model
	}
}

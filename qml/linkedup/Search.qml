import QtQuick 1.0
import "search"
import "components"

Window {
	id: root
	width: parent.width; height: parent.height
	borderTitle: "Search Results"
	busy: true


	onParamChanged: {
		get(API.search_person(type, param))
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


	property string param
	property string type

	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		anchors.topMargin: borderHeight
		model:  model
		delegate: SearchDelegate{
			onClicked: {
				var comp = Qt.createComponent("Profile.qml")
				var object = comp.createObject(root.parent)
				object.profileID = profileID
				object.caller = root
				root.state = "hidden"
			}
		}
	}

	SearchModel{
		id: model
	}




}

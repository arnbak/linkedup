import QtQuick 1.0
import "../components"


Item{
	id: root
	width: parent.width
	height:  parent.height

	signal posted



	states: [
		State {
			name: "busy"
			PropertyChanges {target: busy; visible: true; running: true}
		}
	]

	function post(){
		var xmlHttp = new XMLHttpRequest();
		var list = API.post_share(status.text)
		var url = list[0]
		var header = list[1]
		var body = list[2]

		xmlHttp.onreadystatechange = function(){
			root.state = ""
			if(xmlHttp.readyState == 4){
				status.text = ""
				status.placeholderText = "Successfully Posted!"
				share.focus = true
			}
		}
		xmlHttp.open( "POST", url, true );
		xmlHttp.setRequestHeader("Content-Type", "text/xml")
		xmlHttp.setRequestHeader("Host", "api.linkedin.com");
		xmlHttp.setRequestHeader("Authorization", header);
		xmlHttp.send( body );
	}

	Button{
		id: share
		text: "Share"
		anchors.top: picBox.bottom
		anchors.right: parent.right
		onClicked: {
			if(status.text !== ""){
				post()
				root.state = "busy"
			}
		}
		Connections{
			onClicked: root.posted()
		}
	}

	BusyIndicator{
		id: busy
		running: false
		visible: false
		anchors.left: parent.left
		anchors.top: picBox.bottom
	}

	Item{
		id: picBox
		anchors.fill: parent
		anchors.topMargin: 5
		anchors.leftMargin: 5
		anchors.rightMargin: 5
		anchors.bottomMargin: share.height



		Image{
			id: profilePic
			source: pictureUrl
			asynchronous: true
			smooth: true
			anchors.left: picBox.left
			anchors.bottom: picBox.bottom
			height: parent.height
			width: height
		}






		TextArea{
			id: status
			height: parent.height
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.leftMargin: profilePic.width + 5
			opacity: 1
			font.pixelSize: 25
			placeholderText: "Enter a Status!"
			Behavior on opacity {NumberAnimation{duration:500}}
		}



	}

}



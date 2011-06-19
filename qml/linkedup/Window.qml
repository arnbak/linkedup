import QtQuick 1.0
import "components"

/*This is the base for every screen in the application.
  Provides a more UX more consistent with the Maemo one*/


Rectangle {
	id: root
	width: parent.width
	height: parent.height

	x:width
	Component.onCompleted: x=0

	property Rectangle caller //used to reference the creator of this window
	property alias border: border.visible
	property alias borderHeight: border.height
	property alias borderTitle: title.text
	property alias busy: loading.running
	property bool isRoot: false
	property SystemPalette palette: palette
	Behavior on x{NumberAnimation{duration:  250}}

	SystemPalette{id: palette}
	color: palette.light

	signal getFinished(string xml, string statusCode, string statusText)
	signal deleteFinished(string xml, string statusCode, string statusText)
	signal postFinished(string xml, string statusCode, string statusText)
	signal back()

	function get(url){
		root.busy = true
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				root.busy = false
				root.getFinished(xmlHttp.responseText, xmlHttp.status, xmlHttp.statusText)
//				console.log("\n\n"+xmlHttp.status)
//				console.log(xmlHttp.statusText)
//				console.log(xmlHttp.responseText)
			}
		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}

	function httpDelete(url){
		root.busy = true
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				root.busy = false
				root.deleteFinished(xmlHttp.responseText, xmlHttp.status, xmlHttp.statusText)
			}
		}
		xmlHttp.open( "DELETE", url );
		xmlHttp.send( null );
	}

	function post(list){
		root.busy = true
		var xmlHttp = new XMLHttpRequest();
//		var list = API.post_share(status.text)
		var url = list[0]
		var header = list[1]
		var body = list[2]

		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				root.busy = false
				root.postFinished(xmlHttp.responseText, xmlHttp.status, xmlHttp.statusText)
			}
		}
		xmlHttp.open( "POST", url, true );
		xmlHttp.setRequestHeader("Content-Type", "text/xml")
		xmlHttp.setRequestHeader("Host", "api.linkedin.com");
		xmlHttp.setRequestHeader("Authorization", header);
		xmlHttp.send( body );
	}

	function close(){
		if(!isRoot){
			root.state = "new"
			caller.state = ""
			root.destroy(2000)
		}else{
			Notifier.minimize()
		}

	}

	Rectangle {
		id: border
		height: back.height
		color: palette.dark
		anchors.top: parent.top
		anchors.topMargin: 0
		anchors.right: parent.right
		anchors.rightMargin: 0
		anchors.left: parent.left
		anchors.leftMargin: 0
		z:100

		Text {
			id: title
			anchors.left: back.right
			anchors.margins: 10
			anchors.verticalCenter: parent.verticalCenter
			color: palette.text
			font.pixelSize: 35
		}

		Button{
			id: back
			iconSource: isRoot ? "qrc:///qml/images/windows.png" : "qrc:///qml/images/previous-small.png"
			anchors.top: parent.top
			anchors.left: parent.left
			onClicked: root.close()
			onPressAndHold: {//for exiting all the way to home
				var par = root
				while(par.caller){
					par.close()
					par = par.caller
				}
			}
			Connections{
				onClicked: root.back()
			}
		}

		Loader{
			id: quitButton
			anchors.top: parent.top
			anchors.right: parent.right
			Component.onCompleted: {
				if(isRoot){
					sourceComponent = quitComp
				}
			}

			Component{
				id: quitComp
				Button{
					iconSource: "qrc:///qml/images/x.png"
					onClicked: Qt.quit()
				}
			}
		}

		BusyIndicator{
			id: loading
			anchors.right: parent.right
			running: false
			anchors.verticalCenter: parent.verticalCenter
			states: [
				State {
					name: "hidden"
					when: loading.running == false
					PropertyChanges {target: loading; visible: false}
				}
			]
		}
	}

	states: [
		State {
			name: "hidden"
			PropertyChanges {target: root; x: -root.width}
		},
		State {
			name: "new"
			PropertyChanges {target: root; x: root.width}
		}
	]
}

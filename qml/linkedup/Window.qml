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
	property SystemPalette palette: palette
	Behavior on x{NumberAnimation{duration:  250}}

	SystemPalette{id: palette}
	color: palette.light

	function close(){
		root.state = "new"
		caller.state = ""
		root.destroy(500)
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
			iconSource: "qrc:///qml/images/previous-small.png"
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

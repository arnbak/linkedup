import QtQuick 1.0
import "../components"

Item {
	id: root

	signal clicked
	property alias source: button.iconSource
	property string name
	property string title

	height: 100
	width: height

	Button{
		anchors.fill: parent
		id: button
		smooth: true
		Connections{
			onClicked: root.clicked()
		}
	}

	BusyIndicator{
		id: busy
		running: false
		anchors.bottom: parent.bottom
		anchors.right: parent.right
	}

	states: [
		State {
			name: "busy"
			PropertyChanges {target: busy; running: true}
		}
	]


}

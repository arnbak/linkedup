import QtQuick 1.0
import "updates"
import "components"

Window {
	id: root
	state:  "profile"
	border: false

	SystemPalette{id: palette}


	NewConnections{
		id: connections
		anchors.fill: parent
		anchors.bottomMargin: buttonBox.height
		visible: false
		caller: root.caller
		onBack: root.close()
	}

	Shares{
		id: shares
		anchors.fill: parent
		anchors.bottomMargin: buttonBox.height
		visible: false
		caller: root.caller
		onBack: root.close()
	}


	Rectangle{
		id: buttonBox
		width: parent.width
		height: row.height
		color: palette.dark
		anchors.bottom: parent.bottom
		Row{
			id: row
			Button{
				id: profileButton
				iconSource: "qrc:///qml/images/user-small.png"
				onClicked: root.state = "profile"
			}
			Button{
				id: connectionsButton
				iconSource: "qrc:///qml/images/link-small.png"
				onClicked: root.state = "connections"
			}
		}


	}

	states: [
		State {
			name: "profile"
			PropertyChanges {target: shares; visible: true}
		},
		State {
			name: "connections"
			PropertyChanges {target: connections; visible: true}
		}
	]
}

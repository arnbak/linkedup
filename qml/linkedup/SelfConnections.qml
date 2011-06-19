import QtQuick 1.0
import "selfConnections"
import "components"

Window {
	id: root
	busy: true
	borderTitle: "Connections"
	signal clicked(string xml)

	onProfileIDChanged: get(API.get_connections_by_id(profileID))
	onGetFinished: {
		model.xml = xml
		root.busy = false
	}


	property string profileID

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

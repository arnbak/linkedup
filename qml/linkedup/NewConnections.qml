import QtQuick 1.0
import "newConnections"
import "components"

Window {
	id: root
	borderTitle: "New Connections"

	Component.onCompleted: get(API.get_updates_current())
	onGetFinished: model.xml = xml

	NewConnectionsModel{id: model}

	ListView{
		id: list
		clip: true
		spacing: 20
		anchors.fill: parent
		anchors.topMargin: borderHeight
		model:  model
		cacheBuffer: 10
		delegate: NewConnectionsDelegate{
			onRequestStarted: root.busy = true
			onLikeSent: root.busy = false
			onCommentSent: root.busy = false
			onClicked: {
				var comp = Qt.createComponent("Profile.qml")
				var object = comp.createObject(root.parent)
				object.profileID = profileID
				object.caller = root
				root.state = "hidden"
			}

		}
	}



}

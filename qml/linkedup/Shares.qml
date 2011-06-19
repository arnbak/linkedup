import QtQuick 1.0
import "shares"
//import "components"

Window {
	id: root
	busy: true
	borderTitle: "Shares"
	signal clicked(string xml)

	Component.onCompleted: {
		get(API.get_shares_current())
	}
	onGetFinished: {
		root.busy = false
		model.xml = xml
	}


	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		anchors.topMargin: borderHeight
		model:  model
		delegate: SharesDelegate{
			onClicked: {
				var comp = Qt.createComponent("Profile.qml")
				var object = comp.createObject(root.parent)
				object.profileID = id
				object.caller = root
				root.state = "hidden"
			}
			onRequestStarted: root.busy = true
			onLikeSent: root.busy = false
			onCommentSent: root.busy = false
		}
	}


	SharesModel{
		id: model
	}
}

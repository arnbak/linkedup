import QtQuick 1.0
import "selfConnections"

Rectangle {
	id: root
	anchors.fill: parent


	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		model:  model
		delegate: SelfConnectionsDelegate{}
	}


	SelfConnectionsModel{
		id: model
		xml: API.get_connections_current()
	}
}

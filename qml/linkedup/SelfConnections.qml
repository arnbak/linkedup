import QtQuick 1.0
import "selfConnections"

Rectangle {
	id: root
	anchors.fill: parent

	signal clicked(string xml)

	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		model:  model
		delegate: SelfConnectionsDelegate{
			Connections{
				onClicked: root.clicked(xml)
			}
		}
	}


	SelfConnectionsModel{
		id: model
		xml: API.get_connections_current()
	}
}

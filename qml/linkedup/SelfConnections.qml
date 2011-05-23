import QtQuick 1.0
import "search"

Rectangle {
	id: root
	anchors.fill: parent


	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		model:  model
		delegate: SearchDelegate{
//			Connections{
//				onClicked: root.clicked(xml)
//			}
		}
	}


	SearchModel{
		id: model
		query: "/connections/person"
		xml: API.get_connections_current()
	}
}

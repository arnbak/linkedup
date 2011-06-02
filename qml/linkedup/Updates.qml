import QtQuick 1.0
import "updates"
import "components"

Window {
	id: root

	borderTitle: "Updates"
	signal clicked(string xml)



	ListView{
		id: list
		clip: true
		spacing: 20
		anchors.fill: parent
		anchors.topMargin: borderHeight
		model:  model
		delegate: UpdatesDelegate{
//			Connections{
//				onClicked: root.clicked(xml)
//			}
		}
	}


	UpdatesModel{
		id: model
		xml: API.get_updates_current()
	}
}

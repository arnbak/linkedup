import QtQuick 1.0

Flickable {
	id: root
	width: parent.width
	height: 180

	flickableDirection: Flickable.HorizontalFlick
	contentWidth: 100*8+(30*7)

	Row{
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: -20
		spacing: 30
		Repeater{
			anchors.verticalCenter: parent.verticalCenter
			id: repeater
			model: 8
			delegate: ToolbarIcon{
//				Component.onCompleted: {
//					switch(index){
//					}
//				}
			}
	}



	}


}

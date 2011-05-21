import QtQuick 1.0

Flickable {
	id: root
	width: parent.width
	height: 180

	signal clicked (string name)

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
				Connections{
					onClicked: root.clicked(name)
				}

				Component.onCompleted: {
					switch(index){
					case 0: {name = "profile"; source = "qrc:///qml/images/user.png";break;}
					case 1: {name = "search"; source = "qrc:///qml/images/searchView.png" ;break;}
					case 2: {name = "inbox"; source = "qrc:///qml/images/email.png" ;break;}
					default: {name = "";break;}
					}
				}
			}
	}



	}


}

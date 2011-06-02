import QtQuick 1.0


Flickable {
	id: root
	width: parent.width
	height: 180

	property string title
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
				onClicked: root.title = title

				Component.onCompleted: {
					switch(index){
					case 0: {title = "Me"; name = "profile"; source = "qrc:///qml/images/home.png"};break
					case 1: {title = "Search"; name = "search"; source = "qrc:///qml/images/searchView.png"};break
					case 2: {title = "User"; name = "viewConnection"; source = "qrc:///qml/images/user.png"};break
					case 3: {title = "Mail"; name = "mail"; source = "qrc:///qml/images/email.png"};break
					case 4: {title = "Connections"; name = "connections"; source = "qrc:///qml/images/connections.png"};break
					case 5: {title = "News"; name = "news"; source = "qrc:///qml/images/news.png"};break
					default: {name = ""};break
					}
				}
			}
	}



	}


}

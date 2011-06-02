import QtQuick 1.0
import "components"
import "search"
import "profile"

/*The home screen in which other screens are launched*/
Window {
	id: window
	width: parent.width
	height: parent.height
	border: false

	signal clicked()

	SearchBar{
		id: searchBar
		z: 1
		anchors.top: parent.top
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.margins: 10
		Connections{
			onParamChanged: window.clicked()
		}

		onParamChanged: {
			var comp = Qt.createComponent("Search.qml")
			var object = comp.createObject(window.parent)
			object.param = param
			object.type = type
			object.caller = window

		}
	}


	Grid {
		id: grid
		spacing: 10
		rows: 3
		columns: 3
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter

		Column{
			Button{
				iconSource: "qrc:///qml/images/user.png"
				onClicked: {
					var comp = Qt.createComponent("Profile.qml")
					var object = comp.createObject(window.parent);
					object.profileID = "~"
					object.caller = window
				}
				Connections{
					onClicked: window.clicked()
				}

			}
			Text {text: "Your Profile"; anchors.horizontalCenter: parent.horizontalCenter; color: palette.text; font.pixelSize: 20}
		}

		Column{
			Button{
				iconSource: "qrc:///qml/images/connections.png"
				onClicked: {
					var comp = Qt.createComponent("SelfConnections.qml")
					var object = comp.createObject(window.parent)
					object.caller = window
				}
				Connections{
					onClicked: window.clicked()
				}
			}
			Text {text: "Connections"; anchors.horizontalCenter: parent.horizontalCenter; color: palette.text; font.pixelSize: 20}
		}

//		Column{
//			Button{
//				iconSource: "qrc:///qml/images/search.png"
//				onClicked: window.clicked()
//			}
//			Text {text: "Search"; anchors.horizontalCenter: parent.horizontalCenter; color: palette.text; font.pixelSize: 20}
//		}

//		Column{
//			Button{
//				iconSource: "qrc:///qml/images/news.png"
//				Connections{
//					onClicked: window.clicked()
//				}

//				onClicked: {
////					var comp = Qt.createComponent("Updates.qml")
////					var object = comp.createObject(window.parent)
////					object.caller = window
//				}
//			}
//			Text {text: "Updates"; anchors.horizontalCenter: parent.horizontalCenter; color: palette.text; font.pixelSize: 20}
//		}

		Column{
			Button{
				id: button
				iconSource: "qrc:///qml/images/link.png"
				Connections{
					onClicked: window.clicked()
				}

				onClicked: {
					var comp = Qt.createComponent("NewConnections.qml")
					var object = comp.createObject(window.parent)
					object.caller = window
				}
			}
			Text {text: "New Links"; anchors.horizontalCenter: button.horizontalCenter; color: palette.text; font.pixelSize: 20}
		}



	}
}

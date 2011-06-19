import QtQuick 1.0
import "components"
import "search"
import "profile"

/*The home screen in which other screens are launched*/
Window {
	id: window
	width: parent.width
	height: parent.height
	borderTitle: "Home"
	z:100
	isRoot: true

	signal clicked()




	SearchBar{
		id: searchBar
		z: 1
		anchors.top: parent.top
		anchors.topMargin: borderHeight+10
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.margins: 10
		Connections{
			onClicked: window.clicked()
		}

		onClicked: {
			var comp = Qt.createComponent("Search.qml")
			var object = comp.createObject(window.parent)
			object.type = type
			object.param = param
			object.caller = window

		}

		Text {
			id: tip
			text: "<b>Tip:</b> If you don't know what a button does, press and hold it for an explanation!"
			width: parent.width
			wrapMode: Text.WrapAtWordBoundaryOrAnywhere
			anchors.top: parent.bottom
			anchors.topMargin: 20
			font.pixelSize: 18
			color: palette.text
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
				onPressAndHold: Notifier.longNotify("Your Profile:\n\nDisplays your LinkedIn profile.")
				onClicked: {
					if(!wasHeld){
						var comp = Qt.createComponent("Profile.qml")
						var object = comp.createObject(window.parent);
						object.profileID = "~"
						object.caller = window
					}


				}
				Connections{
					onClicked: {
						if(!wasHeld)
							window.clicked()
					}
				}

			}
			Text {text: "Your Profile"; anchors.horizontalCenter: parent.horizontalCenter; color: palette.text; font.pixelSize: 20}
		}

		Column{
			Button{
				iconSource: "qrc:///qml/images/connections.png"
				onPressAndHold: Notifier.longNotify("Connections:\n\nDisplays your first degree LinkedIn connections.");
				onClicked: {
					if(!wasHeld){
						var comp = Qt.createComponent("SelfConnections.qml")
						var object = comp.createObject(window.parent)
						object.profileID =  "~"
						object.caller = window
					}


				}
				Connections{
					onClicked: {
						if(!wasHeld)
							window.clicked()
					}
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

//		Column{
//			Button{
//				id: button
//				iconSource: "qrc:///qml/images/link.png"
//				Connections{
//					onClicked: window.clicked()
//				}

//				onClicked: {
//					var comp = Qt.createComponent("NewConnections.qml")
//					var object = comp.createObject(window.parent)
//					object.caller = window
//				}
//			}
//			Text {text: "New Links"; anchors.horizontalCenter: button.horizontalCenter; color: palette.text; font.pixelSize: 20}
//		}

		Column{
			Button{
				iconSource: "qrc:///qml/images/news.png"
				onPressAndHold: Notifier.longNotify("Updates:\n\nDisplays your LinkedIn updates. This includes your connections making changes to their profiles, making new connections etc...");
				Connections{
					onClicked: {
						if(!wasHeld)
							window.clicked()
					}
				}

				onClicked: {
					if(!wasHeld){
						var comp = Qt.createComponent("Updates.qml")
						var object = comp.createObject(window.parent)
						object.caller = window
					}


				}
			}
			Text {text: "Updates"; anchors.horizontalCenter: parent.horizontalCenter; color: palette.text; font.pixelSize: 20}
		}



	}
}

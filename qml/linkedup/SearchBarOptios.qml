import QtQuick 1.0


Rectangle{
	id: root
	width: 100
	height: parent.height

	property alias text: selected.text
	Rectangle{
		id: clipper
		width: parent.width
		height: parent.height * 8
		color: "white"
		z: 100
		anchors.bottom: parent.top
	}

	Rectangle{
//		color: "#5eb5e0"
		gradient: Gradient {
			GradientStop {
				position: 0.00;
				color: "#83e1e4";
			}
			GradientStop {
				position: 1.00;
				color: "#7b9ec6";
			}
		}
		height: root.height
		width: root.width
		border.width: 0
		border.color: "black"
		z:100

		MouseArea{
			onClicked: {
				if(root.state == "show")
					root.state = ""
				else
					root.state = "show"
			}

			anchors.fill: parent
		}

		Text {
			id: selected
			z: 1
			font.family: "Arial"
			font.pixelSize: 18
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			text: "Profile"
			}
		}

	states: [
		State {
			name: "show"
			PropertyChanges {
				target: options; anchors.bottomMargin: -8 * root.height}
		}
	]

	Column{
		id: options
		anchors.bottom: parent.top
		Behavior on anchors.bottomMargin{PropertyAnimation{easing.type: Easing.InOutCubic;duration: 500 }}
		Repeater{
			model: 7

			Rectangle{
				color: "lightgray"
				height: root.height
				width: root.width
				border.width: 0
				border.color: "black"
				Behavior on y{NumberAnimation{duration:500}}
				MouseArea{anchors.fill: parent}

				MouseArea{
					onClicked:{
						root.text = menuText.name
						root.state = ""
					}

					anchors.fill: parent
				}

				Text {
					id: menuText

					property string name: text

					z: 1
					font.family: "Arial"
					font.pixelSize: 18
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
					Component.onCompleted:{
						switch(index){
						case 0: text = "Profile";break;
						case 1: text = "Updates";break;
						case 2: text = "Jobs";break;
						case 3: text = "Companies";break;
						case 4: text = "Answers";break;
						case 5: text = "Inbox";break;
						case 6: text = "Groups";break;
						default: break;
						}
					}


				}
			}
		}
	}
}






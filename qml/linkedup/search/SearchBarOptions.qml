import QtQuick 1.0


Rectangle{
	id: root
	width: 100
	height: parent.height

	property alias text: selected.text

	SystemPalette{id: palette}

	Rectangle{
		id: clipper
		width: parent.width
		height: parent.height * 8
		color: palette.light
		z: 100
		anchors.bottom: parent.top
	}

	Rectangle{

		height: root.height
		gradient: Gradient {
			GradientStop {
				position: 0.00;
				color: "#d3d3d3";
			}
			GradientStop {
				position: 1.00;
				color: "#c0c0c0";
			}
		}
		width: root.width
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

		Image {
			id: arrow
			source: "qrc:///qml/images/down.png"
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.margins: 5
			scale: .8
		}
		}

	states: [
		State {
			name: "show"
			PropertyChanges {
				target: options; anchors.bottomMargin: ((-repeater.model)-1) * root.height}
		}
	]

	Column{
		id: options
		anchors.bottom: parent.top
		Behavior on anchors.bottomMargin{PropertyAnimation{easing.type: Easing.InOutCubic;duration: 500 }}
		Repeater{
			id: repeater
			model: 2

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
						case 1: text = "Companies";break;
						case 2: text = "Updates";break;
						case 3: text = "Jobs";break;
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






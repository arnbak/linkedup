import QtQuick 1.0

Rectangle {
	id: root

	property alias text: input.text
	signal clicked

	width: parent.width
	height: parent.height
	color: "transparent"

	BorderImage {
		id: bubble

		width: parent.width - x - 20
		horizontalTileMode: BorderImage.Stretch
		border.left: 20
		border.right: 20
		smooth: true
		source: "qrc:///qml/images/bubble.png"

		anchors.margins: 10


		TextEdit {
			id: input
			anchors.rightMargin: 25
			anchors.leftMargin: 30
			anchors.bottomMargin: 20
			anchors.topMargin: 20
			anchors.fill: parent
			font.pixelSize: 12
			wrapMode: Text.Wrap

			Rectangle{
				anchors.fill: parent
				id: background
				z: -1
				anchors.margins: -2
				border.width: 0
				border.color: "black"
			}

			Button{
				id: share
				text: "Share"
				anchors.top: parent.bottom
				anchors.right: parent.right
				anchors.margins: 5
				Connections{
					onClicked: root.clicked()

				}
			}

			states: [ /*creates a placeholder effect*/
				State {
					name: "placeholder"
					when: input.focus == false
					PropertyChanges {target: input; text: "Enter a status!"; color: "gray"}
				}
			]
		}
	}


}

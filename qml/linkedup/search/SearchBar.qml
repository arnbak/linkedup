import QtQuick 1.0
import "../common"

Rectangle {
	id: root
	height: 40
	anchors.left: parent.left
	anchors.right: parent.right
	anchors.rightMargin: 20

	property string param
	property string type
	signal clicked()

	OldButton {
		id: button
		width: parent.height
		radius: 0
		border.color: "gray"
		height: parent.height
		anchors.right: parent.right
		anchors.rightMargin: 0
		anchors.verticalCenter: parent.verticalCenter
		iconUrl: "qrc:///qml/images/search-small.png"
//		onClicked: root.results = API.search_person(searchbaroptions.text, textInput.text)
		onClicked: {
			root.type = searchbaroptions.text
			root.param = textInput.text
			root.clicked()
		}

	}

	 Rectangle {
		 id: rectangle2
		 color: "#00000000"
		 border.width: 0
		 border.color: "black"
		 anchors.fill: parent
		 anchors.bottomMargin: 0
		 anchors.topMargin: 0
		 anchors.rightMargin: 40
		 z:1


		 SearchBarOptions {
			 id: searchbaroptions
			 z:-1
			 anchors.left: parent.left
			 anchors.leftMargin: 0
			 anchors.verticalCenter: parent.verticalCenter
			 width: 150
		 }

		 TextInput {
			id: textInput
			height: 20
			focus: true
			anchors.right: parent.right
			anchors.rightMargin: 5
			anchors.left: parent.left
			anchors.leftMargin: searchbaroptions.width + 5
			anchors.verticalCenter: parent.verticalCenter
			smooth: true
			font.family: "Arial"
			font.pixelSize: 18
			Connections{
				onAccepted: button.clicked()
			}
		 }
	 }


}

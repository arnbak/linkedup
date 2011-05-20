import QtQuick 1.0

Rectangle {
	id: rectangle1
	height: 40
	anchors.left: parent.left
	anchors.right: parent.right
	anchors.rightMargin: 20
	Button {
		id: button
		x: 219
		y: 10
		width: parent.height
		height: parent.height
		anchors.right: parent.right
		anchors.rightMargin: 0
		anchors.verticalCenter: parent.verticalCenter
		iconUrl: "qrc:///qml/images/search.png"
	}

 SearchBarOptios {
	 id: searchbaroptios1
	 anchors.left: parent.left
	 anchors.leftMargin: 0
	 anchors.verticalCenter: parent.verticalCenter
 }

 Rectangle {
	 id: rectangle2
	 color: "#00000000"
	 radius: 5
	 border.width: 0
	 border.color: "black"
	 anchors.fill: parent
	 anchors.bottomMargin: 0
	 anchors.topMargin: 0
	 anchors.rightMargin: 40
	 anchors.leftMargin: searchbaroptios1.width

	 TextInput {
		id: text_input1
		y: 15
		height: 20
		anchors.right: parent.right
		anchors.rightMargin: 5
		anchors.left: parent.left
		anchors.leftMargin: 5
		anchors.verticalCenter: parent.verticalCenter
		smooth: true
		font.family: "Arial"
		font.pixelSize: 18
	 }
 }


}

import QtQuick 1.0

Item {
	id: item
	width: parent.width
	height: background.height + header.height
//	width: 800
//	height: 480

	property alias headerSize: header.fontSize
	property alias headerColor: header.color
	property alias header: header.text

	property alias backgroundColor: background.color
	property alias backgroundHeight: background.height

	property alias textSize: content.fontSize
	property alias textColor: content.color
	property alias text: content.text
	property alias textHeight: content.height

 Rectangle {
	id: background
	gradient: Gradient {
	 GradientStop {
		 position: 0.00;
		 color: "#6aafd1";
	 }
	 GradientStop {
		 position: 1.00;
		 color: "#3399cc";
	 }
	}
	radius: 10
	border.color: "#000000"
	border.width: 1
	anchors.left: parent.left
	anchors.right: parent.right
	anchors.top: parent.top
	height: content.height + 20
	anchors.topMargin: header.height

	 Text {
		 id: content

		 property int fontSize: 18
		wrapMode: Text.Wrap
		 anchors.rightMargin: 10
		 anchors.leftMargin: 10
		 anchors.bottomMargin: 10
		 anchors.topMargin: 10
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		 font.pixelSize: fontSize
//		 onTextChanged: {
//			 if(text === "")
//				 item.visible = false
//		 }
	 }
 }




	 Text {
		id: header

		property int fontSize: 30

		text: "Header"
		z: 1
		font.family: "Arial"
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.topMargin: 0
		font.pixelSize: fontSize
	 }



}

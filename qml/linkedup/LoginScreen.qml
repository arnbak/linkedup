import QtQuick 1.0

Rectangle {
	id: loginScreen
//	width: parent.width; height: parent.height
	width: 800; height:  480

	property string fontStyle: "Arial"
	property int fontSize: 30
	property int smallFontSize: fontSize * .8
	property string fontColor: "#006699"

 Rectangle {
	id: inputBorder
	x: 301
	y: 349
	width: 204
	height: 48
	color: "#00000000"
	radius: 5
 anchors.horizontalCenter: parent.horizontalCenter
	border.color: "#000000"

	 TextInput {
		id: textInput
  y: 46
  anchors.right: parent.right
  anchors.rightMargin: 0
  anchors.left: parent.left
  anchors.leftMargin: 0
  anchors.verticalCenter: parent.verticalCenter
  horizontalAlignment: TextInput.AlignHCenter
		font.pixelSize: 30
		onAccepted: OAuth.access_token(text)
		validator: RegExpValidator{regExp: /[0-9][0-9][0-9][0-9][0-9]/}
	 }
 }

 Rectangle {
	 id: border
	 height: 40
	 color: "#3399cc"
	 anchors.right: parent.right
	 anchors.rightMargin: 0
	 anchors.left: parent.left
	 anchors.leftMargin: 0
	 anchors.top: parent.top
	 anchors.topMargin: 0

	 Text {
		id: borderText
		width: 80
		height: 20
		color: fontColor
		text: "Authorize LinkedUp"
		anchors.left: parent.left
		anchors.leftMargin: 20
		anchors.topMargin: 20
		anchors.top: parent.bottom
		font.bold: true
		font.family: fontStyle
		font.pixelSize: fontSize
	 }
 }

 LoginButton {
	id: loginbutton
 x: 302
 y: 202
	width: 260
	height: 40
 anchors.horizontalCenter: parent.horizontalCenter
 anchors.horizontalCenterOffset: 0
	anchors.margins: 10


 }

 Text {
	 id: text1
	 y: 142

	 height: 20
	 text: "1. Press the login button"
  horizontalAlignment: Text.AlignLeft
  anchors.right: parent.right
  anchors.rightMargin: 0
  anchors.left: parent.left
  anchors.leftMargin: 40
	 font.pixelSize: smallFontSize
	 font.family: fontStyle
	 color: fontColor
 }

 Text {
	 id: text2
	 y: 271
	 height: 20
	 text: "2. Enter the code you receive below"
  horizontalAlignment: Text.AlignLeft
  anchors.right: parent.right
  anchors.rightMargin: 0
  anchors.left: parent.left
  anchors.leftMargin: 40
	 font.pixelSize: smallFontSize
	 font.family: fontStyle
	 color: fontColor
 }

}

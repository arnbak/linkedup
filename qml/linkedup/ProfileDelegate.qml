import QtQuick 1.0

//Component{
//	id: component

	Flickable{
		id: root
//		width: parent.width; height: parent.height
		width: 800; height: 480

		/*Color and font properties*/
		property string fontStyle: "Arial"
		property int fontSize: 25
		property int smallFontSize: fontSize * .8
		property string fontColor: "#006699"

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
			   text: "Welcome back " + firstName + "!"
			   anchors.left: parent.left
			   anchors.leftMargin: 20
			   anchors.topMargin: 10
			   anchors.top: parent.bottom
			   font.bold: true
			   font.family: fontStyle
			   font.pixelSize: fontSize

			   Image {
				   id: profileImage
				   source: pictureUrl
				   anchors.top: parent.bottom
				   anchors.margins: 10
			   }
			}
		}


	}
//}

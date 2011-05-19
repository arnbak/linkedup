import QtQuick 1.0

Component{
	id: component

	Flickable{
		id: root
		width: parent.width; height: parent.height
//		width: 800; height: 480

		/*Color and font properties*/
		property string fontStyle: "Arial"
		property int fontSize: 25
		property int smallFontSize: fontSize * .8
		property string fontColor: "#006699"

		boundsBehavior: Flickable.StopAtBounds

		Text {
		   id: borderText
		   height: 20
		   width: parent.width
		   color: fontColor
		   text: "Welcome back " + firstName + "!"
		   anchors.topMargin: 10
		   font.bold: true
		   font.family: fontStyle
		   font.pixelSize: fontSize

		   StatusBubble{
			   id: status
			   anchors.top: parent.bottom
			   anchors.margins: 10
			   image: pictureUrl
		   }


		}
	}


}

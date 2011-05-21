import QtQuick 1.0

Component{
	id: component

	Flickable{
		id: root
//		width: parent.width; height: parent.height
//		width: 800; height: 480
		anchors.fill: parent

		/*Color and font properties*/
		property string fontStyle: "Arial"
		property int fontSize: 25
		property int smallFontSize: fontSize * .8
		property string fontColor: "#006699"

		boundsBehavior: Flickable.StopAtBounds
		contentHeight: height
		contentWidth: width

		Row{
			id: row
			spacing: 10
			Image {
				id: image
				height:  80
				width: height
				source: pictureUrl
				Component.onCompleted: {
					if(!pictureUrl)
						source = "qrc:///qml/images/profile-picture.png"
				}
			}

			Column{
				Text {font.pixelSize: 20; font.family: "Arial"; text: firstName + " " + lastName}
				Text {font.pixelSize: 16; font.family: "Arial"; text: headline}
			}


		}
	}

}

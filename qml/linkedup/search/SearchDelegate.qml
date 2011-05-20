import QtQuick 1.0



Item {
//    width: parent.width; height: parent.height
	width: 800; height: 80

	Row{
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




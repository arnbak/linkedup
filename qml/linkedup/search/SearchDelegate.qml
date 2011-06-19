import QtQuick 1.0



Item {
	id: root
	width: parent.width; height: row.height

	signal clicked(string profileID)


	Row{
		id: row
		spacing: 10
		Image {
			id: image
			height:  80
			width: height
			smooth: true
			source: pictureUrl
			Component.onCompleted: {
				if(!pictureUrl)
					source = "qrc:///qml/images/profile-picture.png"
			}

			MouseArea{
				anchors.fill: parent
				onClicked: {
					root.clicked(id)
				}
			}
		}

		Column{
			Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: firstName + " " + lastName}
			Text {font.pixelSize: 18; font.family: "Arial"; color: palette.text; text: headline}
			Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: location}
			Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: industry}
		}


	}


}




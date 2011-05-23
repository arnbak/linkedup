import QtQuick 1.0



Item {
	id: root
	width: parent.width; height: row.height

	signal clicked(string xml)

	MouseArea{
		width: row.width
		height: row.height
		Connections{
			onClicked: root.clicked(API.get_person_by_id(id))
		}

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




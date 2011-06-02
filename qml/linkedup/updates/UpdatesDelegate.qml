import QtQuick 1.0


Item {
	id: root
	width: parent.width; height: col.height

	signal clicked(string xml)
	SystemPalette{id: palette}

	Component.onCompleted: {
		if(!newFirstName){
			root.visible = false
			root.height = 0
		}
	}

	MouseArea{
		width: row.width
		height: row.height
		Connections{
			onClicked: root.clicked(API.get_person_by_id(id))
		}

		Column{
			id: col
			spacing: 5

			Row{ //the updating user
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
					Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: firstName + " " + lastName}
					Text {font.pixelSize: 18; font.family: "Arial"; color: palette.text; text: headline}
//					Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: location}
//					Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: industry}
				}


			}

			Row{ //the users new connection
				id: newRow
				spacing: 10
				scale: .9

				Image {
					id: link
					source: "qrc:///qml/images/link.png"
					width: 40
					height: 45
				}

				Image {
					id: newImage
					height:  80
					width: height
					source: newPictureUrl
					Component.onCompleted: {
						if(!newPictureUrl)
							source = "qrc:///qml/images/profile-picture.png"
					}
				}

				Column{
					Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: newFirstName + " " + newLastName}
					Text {font.pixelSize: 18; font.family: "Arial"; color: palette.text; text: newHeadline}
					Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: newIndustry}
				}


			}

		}


	}


}




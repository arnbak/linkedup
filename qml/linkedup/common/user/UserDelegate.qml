import QtQuick 1.0



Item {
	id: root
	width: parent.width; height: column.height

	signal clicked(string xml)
	property string currentXML

	MouseArea{
		width: row.width
		height: row.height
		Connections{
			onClicked: root.clicked(API.get_person_by_id(id))
		}

		Column{
			id: column
			spacing: 20

			Row{ //profile picture and name
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
					Text {font.pixelSize: 15; font.family: "Arial"; color: "gray"; text: location}
					Text {font.pixelSize: 15; font.family: "Arial"; color: "gray"; text: industry}
				}
			}

			Column{
				spacing: 10

//				Section{
//					id:experience
//					header: "Experience"
//					width: root.width
//					backgroundHeight: list.height + 20

//					ListView{
//						id: list
//						clip: true
//						width: parent.width
//						height: contentHeight

//						anchors.top: parent.top
//						anchors.topMargin: experience.headerSize + 10
//						anchors.leftMargin: 10
//						anchors.rightMargin: 10
//						model:  UserPositionModel{xml: root.currentXML}
//						delegate:
//							Column{
//								spacing: 5
//								width: list.width
////								Text {text: title; font.pixelSize: 25; font.family: "Arial";wrapMode: Text.Wrap; anchors.left: parent.left; anchors.right:parent.right; anchors.margins: 10}
////								Text {text: companyName; font.pixelSize: 20;font.family: "Arial"; color: "gray"; wrapMode: Text.Wrap; anchors.left: parent.left; anchors.right:parent.right; anchors.margins: 10}
////								Text {text: summary; font.pixelSize: 20;font.family: "Arial"; wrapMode: Text.Wrap; anchors.left: parent.left; anchors.right:parent.right; anchors.margins: 10}
//							}
//					}
//				}


				Section{
					id:specialtiesSec
					header: "Specialties"
					text: specialties
					width: root.width
					onTextChanged: {
						if(textHeight)
							specialtiesSec.visible = false
					}
				}

				Section{
					id:interestsSec
					header: "Interests"
					text: interests
					width: root.width
					onTextChanged: {
						console.log(text)
					}
				}

				Section{
					id: website
					header: "Website"
					text: "http://www.proposalpro.com"
					width: root.width
				}

			}

		}


	}


}




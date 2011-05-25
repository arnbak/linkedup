import QtQuick 1.0



Item {
	id: root
	width: parent.width; height: column.height

	signal clicked(string xml)

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
				Section{
					id:experience
					header: "Experience"
					text: "i did kfj ladlfkj al;sdjfa;sdfj la;sdf ja;lsdj f;lasjdflkasjd f;lasjfasldf j;lasfsdjfaks ffas jf;asfj;alsj f;lasf jthis!"
					width: root.width
				}

				Section{
					id:educatio
					header: "Education"
					text: "i did kfj ladlfkj al;sdjfa;sdfj la;sdf ja;lsdj f;lasjdflkasjd f;lasjfasldf j;lasfsdjfaks ffas jf;asfj;alsj f;lasf jthis!"
					width: root.width
				}

				Section{
					id:recommendatios
					header: "Recommendations"
					text: "i did kfj ladlfkj al;sdjfa;sdfj la;sdf ja;lsdj f;lasjdflkasjd f;lasjfasldf j;lasfsdjfaks ffas jf;asfj;alsj f;lasf jthis!"
					width: root.width
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




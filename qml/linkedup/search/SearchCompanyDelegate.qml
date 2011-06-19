import QtQuick 1.0



Item {
	id: root
	width: parent.width; height: row.height

	signal clicked(string profileID)
	property string website: websiteUrl

	Component.onCompleted: {
		if(websiteUrl.search("http") < 0){
			website = "http://" + websiteUrl
		}
	}
		Row{
			id: row
			spacing: 10
			Image {
				id: image
				height:  80
				smooth: true
				width: height
				source: logoUrl ? logoUrl : "qrc:///qml/images/profile-picture.png"


				MouseArea{
					anchors.fill: parent
					onClicked: {
						root.clicked(id)
					}
				}
			}

			Column{
				Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: name}
				Text {font.pixelSize: 18; font.family: "Arial"; color: palette.text; text: '<a href="'+website+'">'+website+'</a>'
					onLinkActivated: Qt.openUrlExternally(website)  }
				Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: universalName}
				Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: industry}
			}


		}
//	}


}




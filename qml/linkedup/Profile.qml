import QtQuick 1.0
import "profile"

Window {
	id: root

	width: parent.width; height: parent.height
	borderTitle: "Profile"
	busy: true

	onProfileIDChanged: {
		get(API.get_person_by_id(profileID))
	}

	function get(url){
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				profileXML = xmlHttp.responseText;
				root.busy = false
				loader.sourceComponent = content
			}


		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}


	property string profileID
	property string profileXML

	SystemPalette{id: palette}

	Loader{
		id: loader
		anchors.fill: parent
		anchors.topMargin: borderHeight
		visible: false
	}

	Component{
		id: content
		Flickable{
			anchors.fill: parent
//			anchors.topMargin: borderHeight
			contentHeight: column.height

			Column{
				id: column
				anchors.top: parent.top
				width: parent.width
				spacing: 50

				ListView{
					id: general
					width: parent.width
					model: ProfileModel{xml: profileXML}
					interactive: false
					delegate: ProfileDelegate{
						Component.onCompleted: general.height = height
					}
				}

				ListView{
					id: specialty
					model: ProfileModel{xml: profileXML}
					width: parent.width
					interactive: false
					header: Text{text: "Specialties"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					delegate: SpecialtiesDelegate{
						Component.onCompleted: specialty.height = height
					}
					onCountChanged: {
						console.log(count)
						if(count === 0){

							visible = false
						}
					}
				}

				ListView{
					id: honor
					model: ProfileModel{xml: profileXML}
					width: parent.width
					interactive: false
					header: Text{text: "Honors"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					delegate: HonorsDelegate{
						Component.onCompleted: honor.height = height
					}
				}

				ListView{
					id: association
					model: ProfileModel{xml: profileXML}
					width: parent.width
					interactive: false
					header: Text{text: "Associations"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					delegate: AssociationsDelegate{
						Component.onCompleted: association.height = height
					}
				}

				ListView{
					id: interest
					model: ProfileModel{xml: profileXML}
					width: parent.width
					interactive: false
					spacing: 20
					header: Text{text: "Interests"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					delegate: InterestsDelegate{
						Component.onCompleted: interest.height = height
					}
				}

				ListView{
					id: summaryList
					model: ProfileModel{xml: profileXML}
					width: parent.width
					interactive: false
					spacing: 20
					header: Text{text: "Summary"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					delegate: SummaryDelegate{
						width: summaryList.width
						Component.onCompleted: summaryList.height = height
					}
				}


				Column{
					id: educationColumn
					width: parent.width
					spacing: 10
					Text{text: "Education"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					ListView{
						id: education
						model: EducationsModel{xml: profileXML}
						width: parent.width
						interactive: true
						orientation: ListView.Horizontal
						snapMode: ListView.SnapOneItem
						clip: true
						flickDeceleration: 1000



						delegate: EducationsDelegate{
							width: education.width
							Component.onCompleted: {
								if(height > education.height)
									education.height = height
							}
						}
					}

				}


				ProfileSection{
					id: positions
					title: "Positions"
					interactive: true
					model: PositionsModel{xml: profileXML}
					delegate: PositionsDelegate{
						width: positions.width
						Component.onCompleted: {
							positions.contentHeight = height > positions.contentHeight ? height : positions.contentHeight
						}
					}
				}

//				Column{
//					width: parent.width
//					spacing: 10
//					Text{text: "Positions"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
//					ListView{
//						id: positions
//						model: PositionsModel{xml: profileXML}
//						width: parent.width
//						interactive: true
//						orientation: ListView.Horizontal
//						snapMode: ListView.SnapOneItem
//						clip: true
//						flickDeceleration: 1000

//						delegate: PositionsDelegate{
//							width: positions.width
//							Component.onCompleted: {
//								if(height > positions.height)
//									positions.height = height//*positions.count
//							}
//						}
//					}

//				}


				Column{
					width: parent.width
					spacing: 10
					Text{text: "Recommendations"; font.pixelSize: 30; font.family: "Arial"; color: palette.text}
					ListView{
						id: recommendation
						model: RecommendationModel{
							xml: profileXML
							onStatusChanged: {/*show the entire component when done*/
								if(status === XmlListModel.Ready && xml)
									loader.visible = true
							}
						}
						width: parent.width
						interactive: true
						orientation: ListView.Horizontal
						snapMode: ListView.SnapOneItem
						clip: true
						flickDeceleration: 1000

						delegate: RecommendationDelegate{
							width: recommendation.width
							Component.onCompleted: {
								if(height > recommendation.height)
									recommendation.height = height
							}
						}
					}

				}



			}

		}

	}






}

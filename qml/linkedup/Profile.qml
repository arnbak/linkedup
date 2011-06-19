import QtQuick 1.0
import "profile"
import "components"
import "common"

Window {
	id: root

	width: parent.width; height: parent.height
	borderTitle: "Profile"

	onProfileIDChanged: get(API.get_person_by_id(profileID))
	onGetFinished: {
		if(statusCode === "401"){
			root.connected = false
			get(API.get_person_public_by_id(profileID))
		}else{
			loader.sourceComponent = content
			profileXML = xml
		}
	}

	property bool connected: true
	property string profileID
	property string profileXML

	property string firstName
	property string lastName


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
			id: flickable
			anchors.fill: parent
			contentHeight: column.height + 50

			Column{
				id: column
				anchors.top: parent.top
				width: parent.width
				spacing: 25


				ListView{
					id: general
					width: parent.width
					model: ProfileModel{xml: profileXML}
					interactive: false
					delegate: ProfileDelegate{
						Component.onCompleted: {
							general.height = height
							root.firstName = firstName
							root.lastName = lastName
						}
					}
				}


				Row{
					id: buttonRow
//					Component.onCompleted: root.brow = buttonRow
					EmailDialog{
						id: emailButton
						toID: "~"
						expandedWidth: root.width
						onSendingMessage: root.busy = true
						onMessageSent: root.busy = false
					}

				}

				Component{
					id: inviteComp
					InviteDialog{
						id: inviteButton
						firstName: root.firstName
						lastName: root.lastName
						expandedWidth: root.width
						onSendingMessage: root.busy = true
						onMessageSent: root.busy = false
					}
				}


				ProfileModel{
					id: profileModel
					xml: profileXML
					onStatusChanged: {
						if(status === XmlListModel.Ready && count){
							loader.visible = true
							if(!User.connected(root.profileID))
								var dialog = inviteComp.createObject(buttonRow)

							root.borderTitle = get(0).firstName + " " + get(0).lastName
							if(get(0).specialties)
								var slist = specialComp.createObject(column)
							if(get(0).honors)
								var hlist = honorComp.createObject(column)
							if(get(0).association)
								var alist = associationComp.createObject(column)
							if(get(0).interests)
								var ilist = interestComp.createObject(column)
							if(get(0).summary)
								var sumlist = summaryComp.createObject(column)

						}
					}
				}


				Component{
					id: specialComp
					Section{
						id: specials
						text: "Specialties"
						model: profileModel
						delegate: SpecialtiesDelegate{}
					}
				}


				Component{
					id: interestComp
					Section{
						id: interest
						text: "Interests"
						model: profileModel
						delegate: InterestsDelegate{}
					}
				}



				Component{
					id: honorComp
					Section{
						id: honor
						text: "Honors"
						model: profileModel
						delegate: HonorsDelegate{}
					}
				}




				Component{
					id: associationComp
					Section{
						id: association
						text: "Associations"
						model: profileModel
						delegate: AssociationsDelegate{}
					}
				}









				Component{
					id: summaryComp
					Section{
						id: summaryList
						text: "Summary"
						model: profileModel
						delegate: SummaryDelegate{}
					}
				}





				EducationsModel{
					id: educationModel
					xml: profileXML
					onStatusChanged: {
						if(status === XmlListModel.Ready){
							if(count)
								var list = eduComp.createObject(column)
						}
					}
				}
				Component{
					id: eduComp
					Section{
						id: edu
						text: "Education"
						backgroundColor: "transparent"
						model: educationModel
						delegate: EducationsDelegate{}
					}
				}




				PositionsModel{
					id: positionsModel
					xml: profileXML
					onStatusChanged: {
						if(status === XmlListModel.Ready){
							if(count)
								var list = positionsComp.createObject(column)
						}
					}
				}
				Component{
					id: positionsComp
					Section{
						id: positions
						text: "Positions"
						backgroundColor: "transparent"
						model: positionsModel
						delegate: PositionsDelegate{}
					}
				}




				RecommendationModel{
					id: recommendationModel
					xml: profileXML
					onStatusChanged: {
						if(status === XmlListModel.Ready){
							if(count)
								var list = recommendationComp.createObject(column)
						}
					}
				}

				Component{
					id: recommendationComp
					Section{
						id: recommendation
						text: "Recommendations"
						backgroundColor: "transparent"
						model: recommendationModel
						delegate: RecommendationDelegate{}
					}
				}



			}

		}

	}






}

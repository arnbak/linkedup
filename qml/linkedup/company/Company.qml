import QtQuick 1.0
import "../"
import "../common"
import "../components"

Window {
	id: root

	width: parent.width; height: parent.height
	borderTitle: "Company"
//	busy: true

	onProfileIDChanged: get(API.get_company_by_id(profileID))
	onGetFinished: {
//		root.busy = false
		profileXML = xml
		loader.sourceComponent = content
		loader.visible = true
//		console.log(xml)
	}

	onPostFinished: {
//		root.busy = false
		console.log(xml, statusCode, statusText)
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
			contentHeight: column.height + 50

			Column{
				id: column
				anchors.top: parent.top
				width: parent.width
				spacing: 10

				ListView{
					id: general
					width: parent.width
					model: CompanyModel{xml: profileXML}
					interactive: false
					delegate: CompanyDelegate{
						id: compDel
						Component.onCompleted: general.height = height
						onFollow: root.post(API.post_company_follow(id))
						onStopFollow: root.httpDelete(API.delete_company_following(id))
						Connections{
							target: root
							onPostFinished: {
								var x = xml
								var sCode = statusCode
								var sText = statusText
								if(sCode === "201"){
									compDel.following = true
									User.follow(id,name) //add the company id to the QHash
								}
							}
							onDeleteFinished:{
								var x = xml
								var sCode = statusCode
								var sText = statusText
								if(sCode === "201"){
									compDel.following = false
									User.stopFollow(id) //remove the company id from the QHash
								}
							}
						}
					}
				}


				Section{
					id: specialties
					text: "Specialties"
					listSpacing: 10
					model: SpecialtiesModel{xml: profileXML}
					delegate: SpecialtiesDelegate{
						Component.onCompleted: {
							specialties.expandedHeight = height* specialties.count
						}

					}
				}

				Section{
					id: locations
					text: "Locations"
					listSpacing: 20
					model: LocationsModel{xml: profileXML}
					delegate: LocationsDelegate{
						Component.onCompleted: {
							locations.expandedHeight = height* locations.count
						}

					}
				}





			}

		}

	}






}

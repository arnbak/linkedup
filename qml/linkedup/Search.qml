import QtQuick 1.0
import "search"
import "components"
import "common"

Window {
	id: root
	width: parent.width; height: parent.height
	borderTitle: "Search Results"

	onGetFinished: root.xml = xml

	onParamChanged: search(param, pagedList.start,pagedList.count)

	function search(param, start,count){
		if(type === "Profile"){
			get(API.search_person(param,start,count))
		}else if(type === "Companies"){
			get(API.search_company(param,start,count))
		}
	}

	property string param
	property string type

	property string xml

	PagedList{
		id: pagedList
		xml: root.xml
		onXmlSet: root.busy = true
		onXmlLoaded: root.busy = false
		pageQuery: root.type === "Profile" ? "/people-search/people" : "/company-search/companies"
		model: root.type === "Profile" ? searchModel : companyModel
		delegate: root.type === "Profile" ? searchDelegate : companyDelegate
		Connections{
			onStartChanged: root.search(root.param, pagedList.start, pagedList.count)
		}
	}



	/*model and delegate for people searches*/
	SearchModel{
		id: searchModel
		xml: root.xml
	}
	Component{
		id: searchDelegate
		SearchDelegate{
			onClicked: {
				var comp = Qt.createComponent("Profile.qml")
				var object = comp.createObject(root.parent)
				object.profileID = profileID
				object.caller = root
				root.state = "hidden"
					}
				}
	}


	/*model and delegate for company searches*/
	SearchCompanyModel{
		id: companyModel
		xml: root.xml
	}
	Component{
		id: companyDelegate
		SearchCompanyDelegate{
			onClicked: {
				var comp = Qt.createComponent("company/Company.qml")
				var object = comp.createObject(root.parent)
				object.profileID = profileID
				object.caller = root
				root.state = "hidden"
					}
				}
	}




}

import QtQuick 1.0
import "main"
import QtWebKit 1.0

Item {
	id: root
	width: 480
	height: 800

	property string updaterShown

	Component.onCompleted: {

		if(Settings.get("oauth_token") === "" || Settings.get("oauth_token_secret") === "")
			getAuthorization()
		else{
			createHome()
		}

	}

	/**
	  Downloads the companies that the user is currently following
	  and hashes them in the User class. Linkedin does not report
	  whether the user is currently following a company when looking
	  at that company, so this is how I can determine before hand.
	  */
	function setCompaniesFollowed(url){
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				User.setCompaniesFollowed(xmlHttp.responseText)
			}
		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}

	/**
	  Same concept as the setCompaniesFollowed function, but
	  instead for dealing with the current member connections
	  */
	function setPeopleConnections(url){
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				User.setPeopleConnections(xmlHttp.responseText)
			}
		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}


	signal authorized
	function getAuthorization(){
		var object = loginScreen.createObject(root)
		object.z = 100
//		loginLoader.sourceComponent = webViewPage
	}


	onAuthorized: createHome()

	function createHome(){
		var homeObj = homeComp.createObject(root)
		var statusObj = statusComp.createObject(root)
		setCompaniesFollowed(API.get_person_following_company())
		setPeopleConnections(API.get_connections_by_id("~"))
	}

	Component{
		id: homeComp
		Home{
			id: home
			onClicked: state = "hidden"
			onStateChanged: {
				root.updaterShown = home.state === "hidden" ? "down":""

			}
		}
	}

	Component{
		id: statusComp
		Status{
			id: updater
			z:100
			profileID: "~"
			anchors.bottom: parent.bottom
			width: parent.width
			shown: root.updaterShown
		}
	}







	/**Screen for authorizing the application
	  This screen is launched if no token is found for
	  the user
	  */
	Component{
		id: loginScreen
		LoginScreen{
			anchors.fill: parent
			Component.onCompleted: root.authorized.connect(authorized)
		}
	}




}

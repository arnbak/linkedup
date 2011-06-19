import QtQuick 1.0
import "components"

Window {
	id: loginScreen
	width: parent.width; height: parent.height
	borderTitle: "Authorize"
	isRoot: true

	signal authorized
	onAuthorized: {
		loginScreen.destroy()
		Notifier.notify("LinkedUp is now authorized!")
	}

	Component.onCompleted: get(OAuth.request_token())
	onGetFinished: {
		OAuth.generate_access_url(xml)
		Notifier.longNotify("You are being redirected to a secure LinkedIn login which will grant you a pin code.\n\nEnter that pin code into the application to authorize it.")
	}

	function authorize(url){
		loginScreen.busy = true
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				loginScreen.busy = false
				if(xmlHttp.status == "200"){
					OAuth.store_key(xmlHttp.responseText)
				}

			}
		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}


TextField{
	id: textField
	anchors.verticalCenter: parent.verticalCenter
	anchors.horizontalCenter: parent.horizontalCenter
	horizontalalignment: Text.AlignHCenter
	onAccepted: authorize(OAuth.access_token(text))
	validator: RegExpValidator{regExp: /[0-9][0-9][0-9][0-9][0-9]/}
}



 Text {
	text: "Enter the pin code you receive below"
	horizontalAlignment: Text.AlignLeft
	anchors.verticalCenter: parent.verticalCenter
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.verticalCenterOffset: -(textField.height +10)
	color: palette.text
	font.pixelSize: 22
 }

}

import QtQuick 1.0

Item{
	id: root
	width: parent.width
	height: parent.height

	property alias xml: model.xml
//	signal clicked(string xml)


	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		model:  UserModel{id: model}
		delegate: UserDelegate{}
	}





}

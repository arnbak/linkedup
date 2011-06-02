import QtQuick 1.0

Column{
	id: root
	width: parent.width

	spacing: 10

	property alias title: title.text
	property XmlListModel model
	property Component delegate
	property alias interactive: list.interactive
	property alias contentHeight: list.height

	Text{id: title
		font.pixelSize: 30
		font.family: "Arial"
		color: palette.text
	}

	ListView{
		id: list
		model: root.model
		width: parent.width
		interactive: false
		orientation: ListView.Horizontal
		snapMode: ListView.SnapOneItem
		clip: true
		flickDeceleration: 1000
		delegate: root.delegate

	}

}

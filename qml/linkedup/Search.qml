import QtQuick 1.0
import "search"

Rectangle {
	id: root
	width: 800; height: 480
//	width: parent.width; height: parent.height

	SearchBar{
		id: searchBar
		z: 100
		anchors.top: parent.top
		anchors.margins: 10
		onResultsChanged: list.model.reload()
	}

	ListView{
		id: list
		clip: true
		spacing: 10
		anchors.fill: parent
		anchors.topMargin: searchBar.height + searchBar.anchors.margins + 10
		model:  model
		delegate: SearchDelegate{}
	}

	SearchModel{
		id: model
		xml: searchBar.results
	}




}

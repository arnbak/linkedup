import QtQuick 1.0
import "../components"



Row{
	id: root

	signal changePage(string start, string count)

	property string count:  "10"
	property int pages: parseInt(numResults/parseInt(root.count)) //10 items per page

	Repeater{
		id: repeater
		model: Math.min(root.pages, 10)
		signal check(int indx)

		delegate: Button{
			id: button
			height: 80
			checkable: true

			property string count: root.count
			property string start: (index*parseInt(count)).toString()
			property int buttonIndex : index

			onClicked: {
				root.changePage(start,count)
				repeater.check(index)
			}

			text: (index+1).toString()
			Connections{
				target: repeater
				onCheck: {
					if(indx !== button.buttonIndex){
						button.checked = false
					}

				}
			}
		}


	}
}



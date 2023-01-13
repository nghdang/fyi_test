import QtQuick 2.0
import QtQuick.Window 2.12
import Qt.labs.folderlistmodel 2.12

Window {
    id: root
    width: 600
    height: 300
    visible: true
    color: "white"

    readonly property int rowHeight: 46

    signal fileSelected(string path)

    Row {
        id: headerRow
        width: parent.width
        height: 46
        anchors.left: parent.left
        Text {
            width: 46
            text: "Path:"
        }
        Text {
            id: selectedPath
            text: filePickerViewModel.currentDir
        }
    }

    FolderListModel {
        id: folderListModel
        folder: filePickerViewModel.currentDir
    }

    ListView {
        id: fileListView
        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        spacing: 10

        model: folderListModel
        delegate: fileDelegate
    }

    Component {
        id: fileDelegate

        Rectangle {
            id: fileWraper
            width: root.width
            height: rowHeight
            color: "transparent"

            Rectangle {
                id: fileIcon
                width: rowHeight
                height: rowHeight
                anchors {
                    left: parent.left
                }
                color: "cyan"
            }

            Text {
                id: fileText
                height: rowHeight
                anchors.left: fileIcon.right
                anchors.verticalCenter: parent.verticalCenter
                text: fileName
            }

            MouseArea {
                id: rowMouseArea
                anchors.fill: parent
                onClicked: {
                    console.log(fileText.text)
                }
            }
        }
    }
}

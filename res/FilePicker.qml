import QtQuick 2.12
import QtQuick.Window 2.12
import Qt.labs.folderlistmodel 2.12

Window {
    id: root
    width: 600
    height: 300
    visible: true
    color: "white"

    signal fileSelected

    Row {
        id: headerRow
        width: parent.width
        height: 32
        anchors.left: parent.left
        Text {
            width: 32
            text: "Path:"
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            id: selectedPath
            text: filePickerViewModel.currentDir
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    FolderListModel {
        id: folderListModel
        folder: filePickerViewModel.currentDir
        showDotAndDotDot: true
        sortField: FolderListModel.Type
    }

    ListView {
        id: fileListView
        anchors {
            left: parent.left
            right: parent.right
            top: headerRow.bottom
            bottom: parent.bottom
        }
        spacing: 38

        model: folderListModel
        delegate: FilePickerRow {
            width: root.width
            isFolder: folderListModel.isFolder(index)
            itemHeight: 32
            itemText: fileName
            enterDirHandler: function enterDir(path) {
                folderListModel.folder = path
                if (path.endsWith("..")) {
                    filePickerViewModel.currentDir = path.split("/").slice(
                                0, -2).join("/")
                } else {
                    filePickerViewModel.currentDir = path
                }
            }
            selectFileHanlder: function selectFile(path) {
                filePickerViewModel.videoPath = path
                root.fileSelected()
            }
        }
        highlight: Rectangle {
            color: "grey"
            visible: fileListView.count !== 0
            width: fileListView.currentItem == null ? 0 : fileListView.currentItem.width
        }
    }
}

import QtQuick 2.0
import QtQuick.Window 2.12

Window {
    id: root
    width: 640
    height: 480
    visible: true

    Button {
        id: filePickerButton
        width: 46
        height: 46

        text: "Open"
        color: "cyan"

        onClicked: filePickerLoader.active = true
    }

    Loader {
        id: filePickerLoader
        active: false
        sourceComponent: FilePicker {
            id: filePicker
        }
    }

    Rectangle {
        id: playerRect
        width: 640
        height: 400
        anchors.top: filePickerButton.bottom
        color: "green"

        Player {
            id: player
            anchors.fill: parent
            videoPath: filePickerViewModel.videoPath
        }
    }

    Loader {
        id: playButtonLoader
        anchors {
            top: playerRect.bottom
            horizontalCenter: playerRect.horizontalCenter
        }
        active: true
        sourceComponent: Button {
            width: 46
            height: 46

            text: "Play"
            color: "green"

            onClicked: {
                playButtonLoader.active = false
                pauseButtonLoader.active = true
                player.start()
            }
        }
    }

    Loader {
        id: pauseButtonLoader
        anchors {
            top: playerRect.bottom
            horizontalCenter: playerRect.horizontalCenter
        }
        active: false
        sourceComponent: Button {
            width: 46
            height: 46

            text: "Pause"
            color: "yellow"

            onClicked: {
                playButtonLoader.active = true
                pauseButtonLoader.active = false
                player.pause()
            }
        }
    }
}

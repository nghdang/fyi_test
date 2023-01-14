import QtQuick 2.0
import QtQuick.Window 2.12
import QtQml 2.12
import QtMultimedia 5.12

Window {
    width: 600
    height: 480
    color: "black"
    visible: true

    function paddingZero(num) {
        if (num < 10) {
            return "0" + num
        } else {
            return "" + num
        }
    }

    function toTimestamp(milliseconds) {
        var hours, minutes, seconds
        hours = Math.floor(milliseconds / 3600000)
        minutes = Math.floor((milliseconds - hours * 3600000) / 60000)
        seconds = Math.floor(
                    (milliseconds - hours * 3600000 - minutes * 60000) / 1000)
        if (hours) {
            return paddingZero(hours) + ":" + paddingZero(minutes)
        } else {
            return paddingZero(minutes) + ":" + paddingZero(seconds)
        }
    }

    Item {
        id: root
        anchors.fill: parent

        Rectangle {
            id: playerRect
            width: root.width
            anchors {
                top: root.top
                bottom: footerBar.top
            }
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "black"
                }
                GradientStop {
                    position: 0.5
                    color: "darkGrey"
                }
                GradientStop {
                    position: 1.0
                    color: "black"
                }
            }

            VideoOutput {
                id: videoOutput
                anchors.fill: parent
                source: mediaPlayer

                MediaPlayer {
                    id: mediaPlayer
                    autoPlay: false
                    autoLoad: true
                    source: filePickerViewModel.videoPath
                }
            }

            Item {
                id: progressBar
                width: parent.width
                height: 10
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 20
                }

                Text {
                    id: positionText
                    width: 20
                    height: progressBar.height
                    anchors {
                        left: progressBar.left
                        leftMargin: 20
                        verticalCenter: progressBar.verticalCenter
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: toTimestamp(mediaPlayer.position)
                    font.pixelSize: 20
                    color: "white"
                }
                PlayerSlider {
                    id: playerSlider
                    anchors {
                        left: positionText.right
                        leftMargin: 20
                        right: durationText.left
                        rightMargin: 20
                        verticalCenter: progressBar.verticalCenter
                    }
                    value: Math.floor(
                               mediaPlayer.position / mediaPlayer.duration * 100)
                    onSeeked: {
                        mediaPlayer.seek(seekValue * mediaPlayer.duration / 100)
                    }
                }

                Text {
                    id: durationText
                    width: 20
                    height: progressBar.height
                    anchors {
                        right: progressBar.right
                        rightMargin: 20
                        verticalCenter: progressBar.verticalCenter
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: toTimestamp(mediaPlayer.duration)
                    font.pixelSize: 20
                    color: "white"
                }
            }
        }

        Item {
            id: footerBar
            width: root.width
            height: 46
            anchors {
                bottom: root.bottom
                bottomMargin: 5
            }

            Rectangle {
                id: footerBackground
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "black"
                    }
                    GradientStop {
                        position: 0.5
                        color: "darkGrey"
                    }
                    GradientStop {
                        position: 1.0
                        color: "black"
                    }
                }
            }

            Button {
                id: filePickerButton
                width: 46
                height: 46
                anchors {
                    left: parent.left
                    leftMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                image: "qrc:/graphics/files.png"

                onClicked: {
                    filePickerLoader.active = true
                }
            }

            Button {
                id: stopButton
                width: 32
                height: 32
                anchors {
                    right: rewindButton.left
                    rightMargin: 20
                    verticalCenter: footerBar.verticalCenter
                }
                image: "qrc:/graphics/stop-button.png"
                onClicked: {
                    mediaPlayer.stop()
                    playPauseButton.state = "paused"
                }
            }

            Button {
                id: rewindButton
                width: 32
                height: 32
                anchors {
                    right: previousTrackButton.left
                    rightMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                image: "qrc:/graphics/rewind.png"
                onClicked: {
                    mediaPlayer.seek(mediaPlayer.position - 10000)
                }
            }

            Button {
                id: previousTrackButton
                width: 32
                height: 32
                anchors {
                    right: playPauseButton.left
                    rightMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                image: "qrc:/graphics/previous-track.png"
            }

            Button {
                id: playPauseButton
                width: 46
                height: 46
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: footerBar.verticalCenter
                }
                state: "paused"
                states: [
                    State {
                        name: "played"
                        PropertyChanges {
                            target: playPauseButton
                            image: "qrc:/graphics/pause-button.png"
                        }
                    },
                    State {
                        name: "paused"
                        PropertyChanges {
                            target: playPauseButton
                            image: "qrc:/graphics/play-button.png"
                        }
                    }
                ]

                onClicked: {
                    if (state === "paused") {
                        state = "played"
                        mediaPlayer.play()
                    } else if (state === "played") {
                        state = "paused"
                        mediaPlayer.pause()
                    }
                }
            }

            Button {
                id: nextTrackButton
                width: 32
                height: 32
                anchors {
                    left: playPauseButton.right
                    leftMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                image: "qrc:/graphics/next-track.png"
            }

            Button {
                id: forwardButton
                width: 32
                height: 32
                anchors {
                    left: nextTrackButton.right
                    leftMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                image: "qrc:/graphics/fast-forward.png"
                onClicked: {
                    mediaPlayer.seek(mediaPlayer.position + 10000)
                }
            }

            Button {
                id: volumeButton

                property real prevVolume

                width: 32
                height: 32
                anchors {
                    right: volumeSlider.left
                    rightMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                state: "unmuted"
                states: [
                    State {
                        name: "unmuted"
                        PropertyChanges {
                            target: volumeButton
                            image: "qrc:/graphics/sound-setting.png"
                        }
                    },
                    State {
                        name: "muted"
                        PropertyChanges {
                            target: volumeButton
                            image: "qrc:/graphics/sound-off.png"
                        }
                    }
                ]
                onClicked: {
                    if (state === "unmuted") {
                        state = "muted"
                        prevVolume = mediaPlayer.volume
                        mediaPlayer.volume = 0.0
                    } else if (state === "muted") {
                        state = "unmuted"
                        mediaPlayer.volume = prevVolume
                    }
                    volumeSlider.value = Math.floor(mediaPlayer.volume * 100)
                }
            }

            PlayerSlider {
                id: volumeSlider
                width: 100
                anchors {
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: footerBar.verticalCenter
                }
                value: Math.floor(mediaPlayer.volume * 100)
                onSeeked: {
                    mediaPlayer.volume = seekValue / 100
                }
            }
        }
    }

    Loader {
        id: filePickerLoader
        active: false
        sourceComponent: FilePicker {
            id: filePicker
            onFileSelected: {
                filePickerLoader.active = false
            }
        }
    }
}

import QtQuick 2.0
import QtMultimedia 5.12

VideoOutput {
    id: root

    property url videoPath

    function start() {
        mediaPlayer.play()
    }
    function pause() {
        mediaPlayer.pause()
    }
    function seek(position) {
        mediaPlayer.seek(position)
    }

    source: mediaPlayer

    MediaPlayer {
        id: mediaPlayer
        autoPlay: false
        autoLoad: true
        source: root.videoPath
    }
}

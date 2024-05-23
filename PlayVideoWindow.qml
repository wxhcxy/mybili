import QtQuick
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Controls 2.5

Window{
    property alias videoSource: mediaPlayer.source
    property alias mediaPlay: mediaPlayer
    width: 1300
    height: 700
    title: "播放"
    onClosing:{
        console.log("关闭播放")
        mediaPlayer.stop()
    }

    Item {
        width: parent.width*0.7
        height: parent.height
        Rectangle{//设置播放页左半部分的背景颜色
            anchors.fill: parent
            color: "black"
        }
        MediaPlayer{
            id : mediaPlayer
            source: "http://localhost:3000/videos/recommend/video3.mp4"
            videoOutput: videoOutPut
            audioOutput: AudioOutput { //开启视频的声音
                id: audio
            }
        }
        VideoOutput{
            id: videoOutPut
            width: parent.width
            height: parent.height*0.65
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            focus: true
            fillMode: VideoOutput.PreserveAspectCrop
        }

    }
}

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



        Rectangle{
            width: parent.width
            anchors.top: videoOutPut.bottom
            anchors.bottom:parent.bottom
            anchors.left: parent.left
            color:"black"
            ColumnLayout{
                anchors.fill: parent
                VideoProcessSlider{
                    id:videoProcessSlider
                }
                Rectangle{
                    width: parent.width
                    Layout.fillWidth: true//加上了这行代码，下面Item的Layout.preferredWidth: parent.width/2才起了作用
                    Layout.fillHeight: true
                    color: "transparent"
                    RowLayout{
                        anchors.fill: parent
                        anchors.bottomMargin: 14
                        Button{
                            id:playBtn
                            visible: false
                            icon.source: "qrc:/icons/video_play_control/play.png"
                            icon.width: 26
                            icon.height: 26
                            Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                            background: Rectangle{
                                anchors.fill: parent
                                color: "black"
                            }
                            onClicked: {
                                mediaPlayer.play()
                                playBtn.visible=false
                                pauseBtn.visible=true
                            }
                        }
                        Button{
                            id:pauseBtn
                            icon.source: "qrc:/icons/video_play_control/pause.png"
                            icon.width: 26
                            icon.height: 26
                            Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                            background: Rectangle{
                                anchors.fill: parent
                                color: "black"
                            }
                            onClicked: {
                                mediaPlayer.pause()
                                pauseBtn.visible=false
                                playBtn.visible=true
                            }
                        }

                    }
                }
            }
        }

    }





}

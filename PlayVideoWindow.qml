import QtQuick
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Controls 2.5

Window{
    id:videoWindow
    property alias videoSource: mediaPlayer.source
    property alias mediaPlay: mediaPlayer
    signal loaderLocalVideo()//加载本地视频列表项的信号
    width: 1300
    height: 700
    title: "播放"
    onClosing:{
        console.log("关闭播放")
        mediaPlayer.stop()
        rightLoader.sourceComponent = networkVideo//若是关闭播放本地视频窗口后，应该把播放窗口右侧恢复为网络视频
    }

    RowLayout{
        anchors.fill: parent

        Item {
            // width: parent.width*0.7
            // height: parent.height
            Layout.preferredWidth: parent.width*0.7
            Layout.preferredHeight:  parent.height
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
                TapHandler{
                    id: videoMouseArea  //单击视频，暂停播放
                    onTapped: {
                        if(mediaPlayer.playing)
                        {
                            pauseBtn.visible=false
                            playBtn.visible=true
                            console.log("已暂停")
                        }
                        if(!mediaPlayer.playing)
                        {
                            playBtn.visible=false
                            pauseBtn.visible=true
                            console.log("已继续播放")
                        }
                        mediaPlayer.playing ? mediaPlayer.pause() : mediaPlayer.play()
                    }
                }
                Keys.onPressed: (event) =>{//键盘快进退和暂停
                                    if(event.key === Qt.Key_Space){
                                        if (mediaPlayer.playing){
                                            mediaPlayer.pause()
                                            pauseBtn.visible=false
                                            playBtn.visible=true
                                            console.log("已暂停")
                                        }
                                        else{
                                            mediaPlayer.play()
                                            playBtn.visible=false
                                            pauseBtn.visible=true
                                            console.log("已继续播放")
                                        }
                                    }
                                    if (event.key=== Qt.Key_Right){
                                        mediaPlayer.setPosition(mediaPlayer.position+2000)
                                    }
                                    if (event.key=== Qt.Key_Left){
                                        mediaPlayer.setPosition(mediaPlayer.position-2000)
                                    }

                                }

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
                            Button{
                                icon.source: "qrc:/icons/video_play_control/next-video.png"
                                icon.width: 30
                                icon.height: 30
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                            }
                            Text {
                                text: {
                                    //进度条时间
                                    var milliseconds = mediaPlayer.position
                                    var minutes = Math.floor(milliseconds/60000)
                                    milliseconds-=minutes*60000
                                    var seconds = milliseconds/1000
                                    seconds = Math.round(seconds)
                                    var processTime=" "
                                    if(minutes<10){
                                        if(seconds<10)
                                            processTime = "0"+minutes+":0"+seconds
                                        else
                                            processTime = "0"+minutes+":"+seconds
                                    }
                                    else{
                                        if(seconds<10)
                                            processTime = minutes+":0"+seconds
                                        else
                                            processTime = minutes+":"+seconds
                                    }
                                    //视频总时长
                                    var durationMilliseconds = mediaPlayer.duration
                                    var durationMinutes = Math.floor(durationMilliseconds/60000)
                                    durationMilliseconds-=durationMinutes*60000
                                    var durationSeconds = durationMilliseconds/1000
                                    durationSeconds = Math.round(durationSeconds)
                                    var durationTime=" "
                                    if(durationMinutes<10){
                                        if(durationSeconds<10)
                                            durationTime = "0"+durationMinutes+":0"+durationSeconds
                                        else
                                            durationTime = "0"+durationMinutes+":"+durationSeconds
                                    }
                                    else{
                                        if(durationSeconds<10)
                                            processTime = durationMinutes+":0"+durationSeconds
                                        else
                                            processTime = durationMinutes+":"+durationSeconds
                                    }
                                    return processTime + " / " + durationTime//最后返回要显示在上面的时间文本信息
                                }
                                color: "#bfbfbf"
                                font.family: "微软雅黑"
                                font.pointSize: 12
                            }
                            Item {
                                Layout.preferredWidth: parent.width/2
                                Layout.fillHeight: true
                            }
                            Button{
                                icon.source: "qrc:/icons/video_play_control/speed.png"
                                icon.width: 32
                                icon.height: 32
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                            }
                            Button{
                                icon.source: "qrc:/icons/video_play_control/voice.png"
                                icon.width: 28
                                icon.height: 28
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                            }
                            Button{
                                icon.source: "qrc:/icons/video_play_control/my.png"
                                icon.width: 30
                                icon.height: 30
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                            }

                        }
                    }
                }
            }

        }

        /*播放窗口右侧显示内容，本地视频列表start*/
        Item {
            id:rightItem
            Layout.preferredWidth: parent.width*0.28
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Loader{
                id:rightLoader
                sourceComponent: networkVideo//默认右侧加载空项。本地播放时，改变sourceComponent的值，从而加载本地视频列表项
            }

        }
        Component{  //右侧网络视频组件
            id:networkVideo
            Item {

            }
        }
        Component{  //右侧本地视频组件
            id:localVideo
            ListView{
                id:localVideoListView
                width: rightItem.width
                height: rightItem.height
                //anchors.fill: parent
                model: 10
                delegate: Rectangle{
                    width: localVideoListView.width
                    height: 200
                    color: Qt.rgba(Math.random(), Math.random(), Math.random(), 0.6)
                }
            }
        }
        /*播放窗口右侧显示内容，本地视频列表end*/

    }
    Connections{    //这个用来连接loaderLocalVideo信号，在点击本地视频后，修改Loader加载的视图,播放窗口右侧显示选择的本地视频列表
        target: videoWindow
        function onLoaderLocalVideo(){
            rightLoader.sourceComponent = localVideo
        }
    }




}

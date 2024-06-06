import QtQuick
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Controls

import mybili //导入从c++注册的qml

Window{
    id:videoWindow
    property alias videoSource: mediaPlayer.source
    property alias mediaPlay: mediaPlayer
    property alias videoOutPutAlias: videoOutPut
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
        spacing: 0
        Item {
            Layout.preferredWidth: parent.width*0.7
            Layout.preferredHeight:  parent.height
            Rectangle{//设置播放页左半部分的背景颜色
                anchors.fill: parent
                color: "black"
            }
            MediaPlayer{
                id : mediaPlayer
                source: "http://localhost:3000/videos/recommend/video3.mp4"
                property int index: 0
                property int sum: 1
                playbackRate: 1
                autoPlay: true
                videoOutput: videoOutPut
                audioOutput: AudioOutput { //开启视频的声音
                    id: audio
                    volume: volumeSlider.value
                }
                onPlayingChanged: {//当视频播放状态发生改变时，触发此事件
                    if(mediaPlayer.playing)
                    {
                        console.log("已暂停")
                        playBtn.icon.source = "qrc:/icons/video_play_control/pause.png"
                    }
                    if(!mediaPlayer.playing)
                    {
                        console.log("正在播放中")
                        playBtn.icon.source = "qrc:/icons/video_play_control/play.png"
                    }
                    if(mediaPlayer.position === mediaPlayer.duration)   // 视频播放到最后则自动播放下一条视频
                    {
                        if(mediaPlayer.index < sum - 1) {
                            mediaPlayer.index++
                            mediaPlayer.source=stackView.currentItem.videoModelAlias.getSource(mediaPlayer.index)
                            mediaPlayer.play()
                        }else {
                            warningPopup.open()
                            warningTimer.start()
                        }
                    }

                }
            }

            Popup {
                id: warningPopup
                anchors.centerIn: parent
                background: Rectangle {
                    opacity: 0.8
                    color: "#1a1c17"
                    border.color: "black"
                }
                Text {
                    color: "white"
                    text: qsTr("已经是最后一条视频了")
                }

                Timer {
                    id :warningTimer
                    interval: 3000   // warningPopup显示3秒
                    repeat: false
                    onTriggered: warningPopup.close()
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
                        mediaPlayer.playing ? mediaPlayer.pause() : mediaPlayer.play()
                    }
                }
                Keys.onPressed: (event) =>{//键盘快进退和暂停
                                    if(event.key === Qt.Key_Space){
                                        if(mediaPlayer.playing)
                                        {
                                            mediaPlayer.pause()
                                            return
                                        }
                                        if(!mediaPlayer.playing)
                                        {
                                            mediaPlayer.play()
                                        }
                                        //因为用下面这行代码会显示一个js箭头函数的警告，所以改用上面的代码
                                        //mediaPlayer.playing ? mediaPlayer.pause() : mediaPlayer.play()
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
                                icon.source: "qrc:/icons/video_play_control/pre-video.png"
                                icon.width: 30
                                icon.height: 30
                                visible: mediaPlayer.index !== 0
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                                TapHandler {
                                   onTapped: {
                                   previousVideo()
                                   videoOutPut.forceActiveFocus()//点击按钮后，将焦点给slider,这样键盘才可以继续控制快退和暂停等
                                }
                              }
                            }
                            Button{
                                id:playBtn
                                visible: true
                                icon.source: "qrc:/icons/video_play_control/pause.png"
                                icon.width: 26
                                icon.height: 26
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                                TapHandler {
                                   onTapped: {
                                    mediaPlayer.playing ? mediaPlayer.pause() : mediaPlayer.play()
                                    videoOutPut.forceActiveFocus()//点击按钮后，将焦点给slider,这样键盘才可以继续控制快退和暂停等
                                   }
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
                                TapHandler {
                                   onTapped: {
                                   nextVideo()
                                   videoOutPut.forceActiveFocus()//点击按钮后，将焦点给slider,这样键盘才可以继续控制快退和暂停等
                                   }
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
                                            durationTime = durationMinutes+":0"+durationSeconds
                                        else
                                            durationTime = durationMinutes+":"+durationSeconds
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
                            Button {
                                id: speedBtn
                                icon.source: "qrc:/icons/video_play_control/speed.png"
                                icon.width: 32
                                icon.height: 32
                                Layout.alignment: Qt.AlignVCenter  //让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }
                                TapHandler {
                                   onTapped: {
                                    speedPopup.open()
                                }
                              }
                            }

                            Popup {  //Popup主要用于在屏幕上弹出一个对话框或浮动窗口，实现用户界面的交互和反馈。
                                id: speedPopup
                                x : speedBtn.x + speedBtn.width/2 - speedPopup.width/2
                                y : speedBtn.y - speedBtn.height*6
                                background: Rectangle {
                                    implicitWidth: speedBtn.width*2
                                    implicitHeight: speedBtn.height*6
                                    opacity: 0.8
                                    color: "#1a1c17"
                                    border.color: "black"
                                }
                                contentItem: Column{
                                    Column {
                                        id: buttonLayout
                                        Repeater{
                                            model: 6   //有6个按钮
                                            Button {
                                                id: speedBtn1
                                                // 按钮的宽度和高度
                                                width: 70
                                                height: 38
                                                // 计算播放速度
                                                property double speed: index === 0 ? (2.0) : ((index === 1) ? 1.5 : (1.5 - (index - 1)*0.25))
                                                text: speed + "x"
                                                palette.buttonText: speed === mediaPlayer.playbackRate ? "#00aeec" : "white"     //修改文字颜色
                                                flat: true      //这个按钮将不会显示任何背景或边框，除非有其他样式或属性覆盖了这一设置
                                                Layout.alignment: Qt.AlignHCenter

                                                // 自定义背景
                                                background: Rectangle {
                                                    property color themecolor: "#1a1c17"
                                                    //从themecolor中提取红绿蓝三种颜色的分量，并给一个透明值为0.1（90%的透明度）
                                                    property color backgroundColor: Qt.rgba(themecolor.r, themecolor.g, themecolor.b, 0.1)
                                                    property color hoveredColor: Qt.rgba(themecolor.r, themecolor.g, themecolor.b, 0.7)
                                                    property color pressedColor: Qt.rgba(themecolor.r, themecolor.g, themecolor.b, 1)
                                                    border.color: "transparent"
                                                    opacity: enabled ? 1 : 0.3
                                                    // 根据鼠标是否在按钮上设置背景色
                                                    color: speedBtn1.hovered ? (speedBtn1.pressed ? pressedColor : hoveredColor) : backgroundColor
                                                    border.width: 1
                                                    Behavior on color {
                                                        ColorAnimation {
                                                            duration: 200
                                                        }
                                                    }
                                                 }
                                                TapHandler {
                                                    onTapped: {
                                                        //计算播放速度
                                                        //var speed = index === 0 ? (2.0) : ((index === 1) ? 1.5 : (1.5 - (index - 1)*0.25))
                                                        mediaPlayer.playbackRate = speed
                                                        mediaPlayer.play()
                                                        speedPopup.close()
                                                   }
                                                }
                                             }
                                          }
                                }
                            }
                        }

                            Button{
                                id: volumeBtn
                                icon.source: "qrc:/icons/video_play_control/voice.png"
                                icon.width: 28
                                icon.height: 28
                                Layout.alignment: Qt.AlignVCenter//让按钮在ColumnLayout中垂直居中
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "black"
                                }

                                TapHandler {
                                    onTapped: {
                                        volumePopup.open()
                                    }
                                }
                            }

                            Popup {  //Popup主要用于在屏幕上弹出一个对话框或浮动窗口，实现用户界面的交互和反馈。
                                id: volumePopup
                                x : volumeBtn.x + volumeBtn.width/2 - volumePopup.width/2
                                y : volumeBtn.y - volumeBtn.height*3 - 15
                                background: Rectangle {
                                    implicitWidth: volumeSlider.width + 20
                                    implicitHeight: volumeSlider.height + 30
                                    opacity: 0.8
                                    color: "#1a1c17"
                                    border.color: "black"
                                }
                                Text {
                                    color: "white"
                                    font.pointSize: 9
                                    // 使用属性绑定和JavaScript的Math.round函数来格式化数字为整数(通过Math.round()四舍五入到最接近的整数)
                                    text: Math.round(volumeSlider.value * 100).toString()
                                }
                                Slider {
                                    id:volumeSlider
                                    orientation: Qt.Vertical
                                    x: volumeSlider.leftPadding + 3
                                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2 + 15
                                    width: 5
                                    stepSize: 0.01
                                    value: 0.5
                                    snapMode: "SnapAlways"


                                    background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 90
                                        width: volumeSlider.availableWidth
                                        height: implicitHeight
                                        color: "#00aeec"
                                        radius: 6

                                    Rectangle {
                                        width: parent.width
                                        height: volumeSlider.visualPosition*parent.height
                                        radius: 6
                                    }
                            }

                                    //滑块
                                    handle: Rectangle {
                                        //滑块位置
                                        x: volumeSlider.leftPadding - 2
                                        y: volumeSlider.topPadding + volumeSlider.visualPosition * (volumeSlider.availableHeight - height)
                                        implicitWidth: 10
                                        implicitHeight: 10
                                        radius: 13
                                        color: volumeSlider.pressed ? "#bdbebf" : "#ffffff"
                                        border.color: "#bdbebf"
                                        }
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
            Rectangle{
                anchors.fill: parent
                color: "#7c8c99"
            }
            Loader{
                id:rightLoader
                anchors.centerIn: parent
                sourceComponent: networkVideo//默认右侧加载空项。本地播放时，改变sourceComponent的值，从而加载本地视频列表项
                onLoaded: videoProcessSlider.forceActiveFocus()//点击按钮后，将焦点给slider,这样键盘才可以继续控制快退和暂停等
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
                width: rightItem.width*0.88
                height: rightItem.height
                topMargin: 18
                spacing: 16
                model:10
                delegate: Image {
                    id:localCoverImage
                    width: localVideoListView.width
                    height: localVideoListView.width*0.6
                    smooth: true//smooth: true启用了图像的平滑处理。
                    fillMode: Image.PreserveAspectCrop//填充模式，保持宽高比填充整个元素
                    antialiasing: true//antialiasing: true启用了图像的抗锯齿处理。
                    source: "http://localhost:3000/images/recommendImages/recommendImage11.png"
                    //本地播放右侧显示的本地视频的封面图片
                    Image {
                        id: localPlayIcon
                        width: 90
                        height: 90
                        visible: false
                        anchors.centerIn: parent
                        source: model.index ===currentIndex? (mediaPlayer.playing ? "qrc:/icons/local_cover_control/play.png" : "qrc:/icons/local_cover_control/pause.png"):"qrc:/icons/local_cover_control/play.png"
                        //这行代码监听播放状态并更新封面的播放暂停图标
                    }
                    //     Rectangle{
                    //     width: localVideoListView.width
                    //     height: 200
                    //     color: Qt.rgba(Math.random(), Math.random(), Math.random(), 0.6)
                    // }
                    HoverHandler{
                        onHoveredChanged: {
                            if(hovered){
                                localPlayIcon.visible = true
                                scaleEnlargeLocalAnimation.running=true
                            }
                            if(!hovered){
                                localPlayIcon.visible = false
                                scaleReducegeLocalAnimation.running=true
                            }
                        }
                    }
                    TapHandler{
                        onTapped: {
                            mediaPlayer.playing ? mediaPlayer.pause() : mediaPlayer.play()
                        }
                    }

                    NumberAnimation {
                        id: scaleEnlargeLocalAnimation//封面放大动画
                        target: localCoverImage
                        property: "scale"
                        to: 1.06
                        duration:100 // 动画持续时间为0.1秒
                    }
                    NumberAnimation {
                        id: scaleReducegeLocalAnimation//封面缩小动画
                        target: localCoverImage
                        property: "scale"
                        to: 1.0
                        duration:100 // 动画持续时间为0.1秒
                    }

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

    function nextVideo(){
        //console.log(stackView.currentItem.videoModelAlias.currentIndex)
        //console.log(stackView.currentItem.gridModelAlias[2])
            if(mediaPlayer.index < mediaPlayer.sum - 1) {
                mediaPlayer.index++
                mediaPlayer.source=stackView.currentItem.videoModelAlias.getSource(mediaPlayer.index)
                mediaPlayer.play()
            }else {
                warningPopup.open()
                warningTimer.start()
            }

    }

    function previousVideo(){
        //console.log(stackView.currentItem.videoModelAlias.currentIndex)
        mediaPlayer.index--
        mediaPlayer.source=stackView.currentItem.videoModelAlias.getSource(mediaPlayer.index)
        mediaPlayer.play()
    }



}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia
import Qt5Compat.GraphicalEffects

import mybili //导入从c++注册的qml  有NetworkHttp类


ScrollView {
    id:recommendScrollView
    clip:true
    focus: true//键盘切换Frame选择视频,要在ScrollView里加上这个，不然没有效果

    Grid{
        id:grid
        leftPadding: parent.width*0.055
        topPadding: 30
        columns: 4
        spacing: 20
        Repeater{
            id:gridModel
            delegate: Frame{
                property alias textColor: videoText.color//这两行设置键盘焦点在子项的时候更换视频文字颜色
                textColor: focus?"#f351c3":"#000000"//这两行设置键盘焦点在子项的时候更换视频文字颜色
                width: window.width*0.2
                height: window.width*0.18
                padding: 0//Frame有内边距
                background: Rectangle{
                    anchors.fill: parent
                    //radius: 8
                    color: "transparent"//加上这个背景，让Frame的边框消失
                }
                Rectangle{
                    id:videoCover
                    width: parent.width
                    height: parent.height*0.64
                    radius: 30
                    border.width: 2
                    Image {
                        id: image
                        anchors.fill: parent
                        visible: false//用OpacityMask遮罩，要加上这个才有效果
                        source: model.imageSource
                        smooth: true//smooth: true启用了图像的平滑处理。
                        fillMode: Image.PreserveAspectCrop//填充模式，保持宽高比填充整个元素
                        antialiasing: true//antialiasing: true启用了图像的抗锯齿处理。

                    }
                    HoverHandler{
                        onHoveredChanged: {
                            hovered ? scaleEnlargeAnimation.running=true : scaleReducegeAnimation.running=true
                        }
                    }
                    TapHandler{
                        onTapped: {
                            console.log(model.videoSource)
                            playVideoWindow.videoSource = model.videoSource
                            playVideoWindow.show()    //playVideo是在Main.qml里用的自定义的PlayVideoView
                            playVideoWindow.mediaPlay.play()//这一行代码，实现效果点击视频后弹出的窗口立马自动播放视频
                        }
                    }
                    NumberAnimation {
                        id: scaleEnlargeAnimation//放大动画
                        target: videoCover
                        property: "scale"
                        to: 1.06
                        duration:100 // 动画持续时间为1秒
                    }
                    NumberAnimation {
                        id: scaleReducegeAnimation//缩小动画
                        target: videoCover
                        property: "scale"
                        to: 1.0
                        duration:100 // 动画持续时间为1秒
                    }
                    Rectangle{
                        id:mask
                        color: "black"//transparent
                        anchors.fill: parent
                        radius: 8
                        visible: false
                        smooth: true
                        antialiasing: true//antialiasing: true启用抗锯齿处理。
                    }

                    OpacityMask{
                        anchors.fill: image
                        source:image
                        maskSource:mask
                        visible:true
                        antialiasing: true//antialiasing: true启用抗锯齿处理。
                    }
                }
                Text {
                    id:videoText
                    width: parent.width
                    height: parent.height*0.24
                    text: model.title
                    font.pointSize: 11
                    font.family: "微软雅黑"
                    wrapMode: Text.Wrap
                    anchors.top: videoCover.bottom
                    anchors.left: parent.left
                    anchors.topMargin: parent.height*0.04
                    // Rectangle{
                    //     anchors.fill: parent
                    //     color: "blue"
                    // }
                    HoverHandler{
                        onHoveredChanged: {
                            hovered ? parent.color="#f351c3" : parent.color="black"
                        }
                    }
                }
                RowLayout{
                    width: parent.width
                    height: parent.height*0.2
                    anchors.top: videoText.bottom
                    anchors.left: parent.left
                    anchors.topMargin: 2
                    spacing: 0
                    Image {
                        id: upIcon
                        Layout.preferredWidth: 20
                        Layout.preferredHeight: 20
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: -2
                        source: "qrc:/icons/grid_video/UP.png"
                        // Rectangle{
                        //     anchors.fill: parent
                        //     color: "red"
                        // }
                    }
                    Text {
                        id: authorName
                        text: model.authorName
                        Layout.preferredWidth: 130
                        Layout.preferredHeight: 20
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 1
                        Layout.leftMargin: -14
                        font.pointSize: 10
                        font.family: "微软雅黑"
                        wrapMode: Text.Wrap
                        color: "#8a8a8a"
                        // Rectangle{
                        //     anchors.fill: parent
                        //     color: "red"
                        // }
                    }
                }




                //键盘切换Frame选择视频start
                scale: focus ? 1.08 : 1
                focus: index === 0
                Keys.onPressed: (event) =>{
                                    switch (event.key) {
                                        case Qt.Key_Right:
                                        focusNextItemInRow()
                                        break;
                                        case Qt.Key_Left:
                                        focusPreviousItemInRow()
                                        break;
                                        case Qt.Key_Down:
                                        focusNextItemInColumn()
                                        break;
                                        case Qt.Key_Up:
                                        focusPreviousItemInColumn()
                                        break;
                                        case Qt.Key_Return://Qt.Key_Return这个才是回车键Enter
                                        //console.log("enter")
                                        //playSignal(model.videoSource)//发射播放信号，携带视频信息参数
                                        {
                                            playVideoWindow.videoSource = model.videoSource
                                            playVideoWindow.show()    //playVideo是在Main.qml里用的自定义的PlayVideoView
                                            playVideoWindow.mediaPlay.play()//这一行代码，实现效果点击视频后弹出的窗口立马自动播放视频
                                        }
                                        break;
                                    }
                                }
                function focusNextItemInRow() {
                    //var nextIndex = (index + 1) % 2
                    if(index === gridModel.count-1)
                    {//index的索引是从0开始的,所以要减一,gridModel.count获取Repeater的模型数量
                        return//如果index === gridModel.count，表面焦点已经在最后一项，不能再向下一个切换
                    }
                    var nextIndex = index + 1
                    getItem(nextIndex).forceActiveFocus()
                    //getItem(nextIndex)是一个函数调用，它返回指定索引的子项。
                    //forceActiveFocus()是一个用于强制设置焦点的方法，它将焦点设置在调用该方法的对象上，即下一个子项。
                }
                function focusPreviousItemInRow() {
                    //var previousIndex = (index - 1 + 2) % 2
                    if(index === 0){
                        return//保证聚焦在第一项的时候不能再左移动
                    }
                    var previousIndex = index - 1
                    getItem(previousIndex).forceActiveFocus()
                }
                function focusNextItemInColumn() {
                    if(index >= gridModel.count - grid.columns)
                    {
                        return//如果index > gridModel.count - grid.columns，表面焦点已经在最后一行，不能再向下一行切换
                    }

                    var nextIndex = index + grid.columns //这里的grid.columns2代表一行有多少个元素
                    getItem(nextIndex).forceActiveFocus()
                }
                function focusPreviousItemInColumn() {
                    if(index < grid.columns){//这里的2代表一行有多少个元素
                        return//保证聚焦在第一行的时候不能再向上移动
                    }
                    var previousIndex = index - grid.columns//这里的2代表一行有多少个元素
                    getItem(previousIndex).forceActiveFocus()
                }
                function getItem(index) {
                    //console.log(gridModel.count)
                    return gridModel.itemAt(index)
                }
                //键盘切换Frame选择视频end

            }
        }
    }


    NetworkHttp{
        id:networkHttp
    }
    VideoModel{
        id:videoModel
    }

    //http网络请求，拿到视频数据
    Component.onCompleted: {
        getRecommendVideosList()
    }
    function getRecommendVideosList(){
        function onReply(reply){//这里的reply参数，是有networkputils.cpp中的replySignal信号发送传递过来的
            networkHttp.onReplySignal.disconnect(onReply);
            var recommendVideos = JSON.parse(reply).recommendVideos//将string转成json数据
            videoModel.processData(recommendVideos)//将请求到的数据传递给playercontroller的m_videosList
            gridModel.model = videoModel
        }
        //绑定一个信号replySignal
        networkHttp.onReplySignal.connect(onReply);//绑定一个信号replySignal,要加on,首字母大写R
        networkHttp.sendRequest("recommend");
    }



}

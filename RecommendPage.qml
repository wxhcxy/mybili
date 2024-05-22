import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia
import Qt5Compat.GraphicalEffects

import mybili //导入从c++注册的qml  有NetworkHttp类


ScrollView {
    id:recommendScrollView
    width: parent.width
    height: parent.height
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
                    height: parent.height*0.7
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
                            console.log("播放视频")
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
                    anchors.topMargin: parent.height*0.06
                    HoverHandler{
                        onHoveredChanged: {
                            hovered ? parent.color="#f351c3" : parent.color="black"
                        }
                    }
                }

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

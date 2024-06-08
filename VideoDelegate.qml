/*这是一个要复用的组件，为了保证低耦合，请不要在这个文档代码里添加其他文档的对象属性*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

//这个qml表示了网格视频中的一个视频的样式,是给Grid中的Repeater的delegate用的

Frame{
    property alias textColor: videoText.color//这两行设置键盘焦点在子项的时候更换视频文字颜色
    property alias selectTapHandler: selectTapHandler
    textColor: focus?"#f351c3":"#000000"//这两行设置键盘焦点在子项的时候更换视频文字颜色
    implicitWidth: (window.width-60)*0.22
    implicitHeight: (window.width-60)*0.2
    padding: 0//Frame有内边距
    background: Rectangle{
        anchors.fill: parent
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
            asynchronous: true//异步加载
        }
        HoverHandler{
            onHoveredChanged: {
                hovered ? scaleEnlargeAnimation.running=true : scaleReducegeAnimation.running=true
            }
        }
        TapHandler{
            id:selectTapHandler
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
        anchors.topMargin: 8
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

}

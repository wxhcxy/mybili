import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts


Frame{
    id:leftSideBar
    Layout.fillHeight: true
    background: Rectangle{//设置左侧栏的背景颜色为透明
        color: "transparent"//color: "green"
    }


    ColumnLayout{
        anchors.fill: parent//设置列布局为填充父级Frame的大小
        Button{
            icon.source: "qrc:/icons/left_side_bar/home-page.png"
            icon.width: 30
            icon.height: 30
            text: "首页"
            palette.buttonText: "#8a8a8a"//修改按钮文本颜色
            display: AbstractButton.TextUnderIcon//设置按钮文字在按钮图标下方
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{//设置按钮颜色为透明
                anchors.fill: parent
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                        parent.contentItem.color="#8a8a8a"//鼠标离开时按钮文本变色
                    }
                }
            }
        }
        Button{
            icon.source: "qrc:/icons/left_side_bar/trend.png"
            icon.width: 36
            icon.height: 36
            text: "动态"
            palette.buttonText: "#8a8a8a"//修改按钮文本颜色
            display: AbstractButton.TextUnderIcon//设置按钮文字在按钮图标下方
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                        parent.contentItem.color="#8a8a8a"//鼠标离开时按钮文本变色
                    }
                }
            }
        }
        Button{
            icon.source: "qrc:/icons/left_side_bar/my.png"
            icon.width: 36
            icon.height: 36
            text: "我的"
            palette.buttonText: "#8a8a8a"//修改按钮文本颜色
            display: AbstractButton.TextUnderIcon//设置按钮文字在按钮图标下方
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                        parent.contentItem.color="#8a8a8a"//鼠标离开时按钮文本变色
                    }
                }
            }
        }
        Item {//这个item项，分割占位作用，空白项
            Layout.preferredHeight: parent.height/5
            Layout.fillWidth: true
        }
        Button{
            icon.source: "qrc:/icons/left_side_bar/email.png"
            icon.width: 30
            icon.height: 30
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                    }
                }
            }
        }
        Button{//切换背景颜色按钮
            icon.source: "qrc:/icons/left_side_bar/background-color.png"
            icon.width: 30
            icon.height: 30
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            ToolTip{
                padding: 0
                visible: parent.hovered//鼠标进入按钮时，显示提示文本
                delay: 0//显示延迟0
                timeout: 5000//5秒后自动消失
                contentItem: Text { //contentItem指定ToolTip的内容
                    text: qsTr("背景颜色")
                    font.pointSize: 10
                    font.family: "微软雅黑"
                    color:"black"
                }
                background: Rectangle{
                    border.width: 0
                    radius: 2
                }
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                    }
                }
            }
        }
        Button{//夜晚白天背景切换
            id:night
            icon.source: "qrc:/icons/left_side_bar/night.png"
            icon.width: 30
            icon.height: 30
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            ToolTip{
                text: qsTr("夜间")
                padding: 0
                visible: parent.hovered//鼠标进入按钮时，显示提示文本
                delay: 0//显示延迟0
                timeout: 5000//5秒后自动消失
                contentItem: Text {
                    text: qsTr("夜间")
                    font.pointSize: 10
                    font.family: "微软雅黑"
                    color:"black"
                }
                background: Rectangle{
                    border.width: 0
                    radius: 2
                }
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                    }
                }
            }
        }
        Button{//夜晚白天背景切换
            id:daytime
            visible: false
            icon.source: "qrc:/icons/left_side_bar/daytime.png"
            icon.width: 30
            icon.height: 30
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            ToolTip{
                padding: 0
                visible: parent.hovered//鼠标进入按钮时，显示提示文本
                delay: 0//显示延迟0
                timeout: 5000//5秒后自动消失
                contentItem: Text {
                    text: qsTr("白天")
                    font.pointSize: 10
                    font.family: "微软雅黑"
                    color:"black"
                }
                background: Rectangle{
                    border.width: 0
                    radius: 2
                }
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                    }
                }
            }
        }
        Button{
            icon.source: "qrc:/icons/left_side_bar/set-up.png"
            icon.width: 30
            icon.height: 30
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        parent.icon.color = "red"
                    }
                    if(!hovered){
                        parent.icon.color = "#8a8a8a"//鼠标离开时按钮图标变色
                    }
                }
            }

        }

    }

}

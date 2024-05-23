import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts

ToolBar{
    width: parent.width
    Layout.fillWidth: true
    height: 60
    background: Rectangle{
        anchors.fill: parent
        color: "transparent"//"#bfbfbf"//transparent
    }
    RowLayout{
        anchors.fill: parent//加上这个，toolbar里的子项垂直居中
        spacing: 40
        Label{
            width: 100
            height: 60
            background: Rectangle{
                anchors.centerIn: parent
                color: "red"
            }

            Image {
                //anchors.fill: parent
                width: 80
                height: 60
                source: "qrc:/icons/head_tool_bar/BILIBILI_LOGO.png"
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
            }
        }


        ToolButton{
            text: "推荐"
            font.pointSize: 14
            background: Rectangle{//按钮背景透明
                anchors.fill: parent
                color: "transparent"
            }

            Text {
                id:tooltext
                text: "一"
                color: "red"
                anchors.top: parent.bottom
                anchors.topMargin: -24
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                font.pointSize: 30
            }
            HoverHandler{
                onHoveredChanged: {
                    hovered ? tooltext.visible=true : tooltext.visible=false
                }
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }
        ToolButton{
            text: "热门"
            font.pointSize: 14
            background: Rectangle{//按钮背景透明
                anchors.fill: parent
                color: "transparent"
            }

            Text {
                id:tooltext2
                text: "一"
                color: "red"
                anchors.top: parent.bottom
                anchors.topMargin: -24
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                font.pointSize: 30
            }
            HoverHandler{
                onHoveredChanged: {
                    hovered ? tooltext2.visible=true : tooltext2.visible=false
                }
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }
        ToolButton{
            text: "本地"
            font.pointSize: 14
            background: Rectangle{//按钮背景透明
                anchors.fill: parent
                color: "transparent"
            }

            Text {
                id:tooltext3
                text: "一"
                color: "red"
                anchors.top: parent.bottom
                anchors.topMargin: -24
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                font.pointSize: 30
            }
            HoverHandler{
                onHoveredChanged: {
                    hovered ? tooltext3.visible=true : tooltext3.visible=false
                }
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }
        Item {
            width: parent.width/4
            Layout.fillWidth: true
            height: parent.height
            // Rectangle{
            //     anchors.fill: parent
            //     color: "green"
            // }
        }

        TextField{
            Layout.preferredWidth: 200
            Layout.preferredHeight: 32
            color: "red"
            placeholderText: "搜索"
            placeholderTextColor: "#adb6b6"
            onAccepted: {
                console.log(text)//按enter键后，会打印当前TextField中输入的文本text
            }
        }

        ToolButton{
            font.pointSize: 14
            icon.source:"qrc:/icons/head_tool_bar/min-size.png"
            background: Rectangle{//按钮背景透明
                id:minSizeBack
                anchors.fill: parent
                radius: 4
                color: "transparent"
            }

            HoverHandler{
                onHoveredChanged: {
                    hovered ? minSizeBack.color="red" : minSizeBack.color="transparent"
                }
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }
        ToolButton{
            font.pointSize: 14
            icon.source:"qrc:/icons/head_tool_bar/max-size.png"
            background: Rectangle{//按钮背景透明
                id:maxSizeBack
                anchors.fill: parent
                radius: 4
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    hovered ? maxSizeBack.color="red" : maxSizeBack.color="transparent"
                }
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }
        ToolButton{
            font.pointSize: 14
            icon.source:"qrc:/icons/head_tool_bar/close.png"
            background: Rectangle{//按钮背景透明
                id:closeBack
                anchors.fill: parent
                radius: 4
                color: "transparent"
            }
            HoverHandler{
                onHoveredChanged: {
                    hovered ? closeBack.color="red" : closeBack.color="transparent"
                }
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }

    }

}


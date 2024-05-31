import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts
import QtQuick.Dialogs


Frame{
    id:leftSideBar
    Layout.fillHeight: true
    background: Rectangle{//设置左侧栏的背景颜色为透明
        color: backgroundWindow.color
        //color: "transparent"//color: "green"
    }

    property int step: 1
    Canvas{
        id:canvas
        width: window.width*1.5    //画布是整个窗口的大小
        height: window.height*1.5
        property int centerX: canvas.width/2
        property int centerY: canvas.height/2
        property int radius: 0

        onPaint: {
            var ctx = canvas.getContext("2d")
            ctx.save()//ctx.save()与 ctx.restore()，只会在两者之间，ctx.restore()之后的ctx会恢复到ctx.save()之前的ctx
            if(backgroundImage.source != ""){
                ctx.drawImage(backgroundImage.source, 0, 0, backgroundImage.width, backgroundImage.height, 0, 0, canvas.width, canvas.height)//将图像绘制到目标画布上
            }
            clearArc(ctx, centerX, centerY, radius)//这个是后面自定义的js函数
            ctx.restore()
        }

        function clearArc(ctx, x, y, radius){
            ctx.beginPath() //开始一次绘制圆的路径
            ctx.globalCompositeOperation = 'destination-out'
            ctx.fillStyle = 'black'
            ctx.arc(x, y, radius, 0, 2*Math.PI)
            ctx.fill()
            ctx.closePath() //结束一次绘制圆的路径
        }
        //定义一个名为clearArc的函数，用于在画布上清除圆形区域。
        //设置绘图的全局组合操作为'destination-out'，填充颜色为黑色，绘制一个半径为radius的圆形，并进行填充。
    }

    Timer{
        id:timer
        interval: 5//可以控制圆形区域延伸的速度
        repeat: true
        onTriggered: {
            if(canvas.radius >= Math.sqrt(Screen.width*Screen.width + Screen.height*Screen.height))
            {//用screen桌面的对角线大小，以确保运行程序后，最大化窗口时，画布能够全部画完窗口
                console.log("背景颜色改变完成")
                timer.stop()
            }
            canvas.radius = canvas.radius + step
            canvas.requestPaint()
        }
    }
    //创建一个计时器，每隔5毫秒触发一次。在触发事件中，将画布的半径增加step值，并请求重绘画布。

    function changeBackgoundColor(color)
    {
        var maxRadius = Math.sqrt(window.width*window.width + window.height*window.height)
        step = maxRadius/100 //改变这个值的大小，可以改变圆形区域延伸的速度

        backgroundWindow.grabToImage(function(result) {//grabToImage方法，用于将其内容保存为图像
            backgroundImage.source = result.url
            backgroundWindow.color = color
            canvas.centerX = 0//这个0和window.height点，才是窗口的左下角
            canvas.centerY = window.height
            canvas.requestPaint()//会再次响应canvas的onPaint
            canvas.radius = 0
            timer.start()
        })
    }


    ColumnLayout{
        anchors.fill: parent//设置列布局为填充父级Frame的大小
        Button{
            icon.source: "qrc:/icons/left_side_bar/return.png"
            icon.width: 30
            icon.height: 30
            Layout.alignment: Qt.AlignCenter//让按钮在ColumnLayout中水平居中
            background: Rectangle{//设置按钮颜色为透明
                anchors.fill: parent
                color: "transparent"
            }
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }
        }
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
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    colorDialog.open()
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    changeBackgoundColor("#000000")
                    night.visible = false
                    daytime.visible = true
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    changeBackgoundColor("#ffffff")
                    night.visible = true
                    daytime.visible = false
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
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
            TapHandler{
                onTapped: {
                    recommendPage.forceActiveFocus() //在点击该按钮时，将焦点给到grid上，每个按钮都加了这行代码
                }
            }


        }

    }

    //颜色对话框
    ColorDialog {
        id: colorDialog
        selectedColor: window.color // 初始颜色设置为当前窗口颜色
        onAccepted: {
            changeBackgoundColor(colorDialog.selectedColor)//启用改变背景颜色的画布动画
        }
    }

}

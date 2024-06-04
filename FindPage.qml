import QtQuick
import QtQuick.Controls //包含常见组件的同时，包括Popup
import QtQuick.Layouts

//用于弹出的窗口
Popup{
    id:popwindow
    //创建内容
    contentItem: ColumnLayout{
        id:collayout
        focus: true
        spacing: 0
        //行布局，用于布局工具按钮
        RowLayout{

            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.fillWidth: true
            Layout.preferredHeight: scaleBtn.height
                //缩放按钮
                ToolButton{
                    id:scaleBtn
                    font.pointSize: 14
                    icon.source:"qrc:/icons/head_tool_bar/max-size.png"
                    background: Rectangle{//按钮背景透明
                        id:maxSizeBack
                        anchors.fill: parent
                        radius: 4
                        color: "transparent"
                    }
                    //缩放动作
                    action: scaleAction

                    HoverHandler{
                        onHoveredChanged: {
                            hovered ? maxSizeBack.color="red" : maxSizeBack.color="transparent"
                        }
                    }

                }
                //关闭按钮
                ToolButton{
                    id:closeBtn
                    font.pointSize: 14
                    icon.source:"qrc:/icons/head_tool_bar/close.png"
                    background: Rectangle{//按钮背景透明
                        id:closeBack
                        anchors.fill: parent
                        radius: 4
                        color: "transparent"
                    }
                    //关闭动作
                    action: closeAction

                    HoverHandler{
                        onHoveredChanged: {
                            hovered ? closeBack.color="red" : closeBack.color="transparent"
                        }
                    }

            }
        }
        //定义窗口状态
        states: [
            State {
                name: "ToUp"
                PropertyChanges {
                    target: popwindow
                    width: window.width
                    height: window.height
                }
            }
        ]


    }





    //定义两种动作
    //关闭
    Action{
        id:closeAction
        onTriggered: popwindow.close()
    }

    //缩放
    Action{
        id:scaleAction
        onTriggered: collayout.state === '' ? collayout.state = "ToUp": collayout.state =''
    }

}


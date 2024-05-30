import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia
import Qt5Compat.GraphicalEffects

import mybili //导入从c++注册的qml  有NetworkHttp类



GridView {
    id: gridView
    property alias videoModelAlias: videoModel
    focus: true
    //flickableDirection: Flickable.VerticalFlick
    leftMargin: window.width*0.02
    cellWidth: (window.width-60)*0.24
    cellHeight:(window.width-60)*0.22
    ScrollBar.vertical: ScrollBar{}//给GridView加上一个垂直的滚动条
    delegate: VideoDelegate {}

    NetworkHttp {
        id: networkHttp
    }
    VideoModel {
        id: videoModel
    }

    //http网络请求，拿到视频数据
    Component.onCompleted: {
        getVideosList()
        console.log("PopularPage.qml In GridView")
    }

    function getVideosList() {
        function onReply(reply) { //这里的reply参数，是有networkputils.cpp中的replySignal信号发送传递过来的
            networkHttp.onReplySignal.disconnect(onReply);
            var popularVideos = JSON.parse(reply).popularVideos //将string转成json数据
            videoModel.processData(popularVideos) //将请求到的数据传递给playercontroller的m_videosList
            gridView.model = videoModel
            console.log(gridView.count)
        }
        //绑定一个信号replySignal
        networkHttp.onReplySignal.connect(onReply); //绑定一个信号replySignal,要加on,首字母大写R
        networkHttp.sendRequest("popular");
    }
}




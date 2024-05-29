import QtQuick
import QtQuick.Controls

import mybili //导入从c++注册的qml  有NetworkHttp类


ScrollView {
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
            //Repeater有model属性,getRecommendVideosList()方法中会给其赋值
            delegate: VideoDelegate{

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
        getVideosList()
        console.log("SearchPage.qml")
    }
    function getVideosList(){
        function onReply(reply){//这里的reply参数，是有networkputils.cpp中的replySignal信号发送传递过来的
            networkHttp.onReplySignal.disconnect(onReply);
            var popularVideos = JSON.parse(reply).popularVideos//将string转成json数据
            videoModel.processData(popularVideos)//将请求到的数据传递给playercontroller的m_videosList
            gridModel.model = videoModel
        }
        //绑定一个信号replySignal
        networkHttp.onReplySignal.connect(onReply);//绑定一个信号replySignal,要加on,首字母大写R
        networkHttp.sendRequest("popular");
    }

}

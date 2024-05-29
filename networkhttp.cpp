#include "networkhttp.h"


NetworkHttp::NetworkHttp(QObject *parent)
    : QObject{parent}
{
    m_manager = new QNetworkAccessManager(this);

    //当在不同qml、cpp等地方要请求数据时，在对应的qml、cpp调用sendRequest("")函数，请求查询数据
    //sendRequest("");//1

    //onReplied槽函数与m_manager进行信号绑定，当m_manager请求数据成功后，调用该槽函数
    connect(m_manager,&QNetworkAccessManager::finished,this,&NetworkHttp::onReplied);//2
}

void NetworkHttp::onReplied(QNetworkReply *reply)
{
    QByteArray QByteArray = reply->readAll();
    //qDebug()<<QByteArray.data();
    emit replySignal(QByteArray.data());//3
    reply->deleteLater();
    //qDebug()<<reply->readAll();
    //发送一个自定义信号，在需要接受数据的地方，绑定信号
    //reply->readAll()返回一个字符串
    //reply->readAll()触发一次之后,仅返回一次数据，再调用该函数数据是空的
}


//请求数据
void NetworkHttp::sendRequest(QString url)
{
    //QUrl requestUrl("http://localhost:3000"+url);
    m_manager->get(QNetworkRequest(QUrl("http://localhost:3000/"+url)));//1
}

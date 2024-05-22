#ifndef NETWORKHTTP_H
#define NETWORKHTTP_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include <QtQml/qqmlregistration.h>//注册qml的头文件
#include <QQmlEngine>

class NetworkHttp: public QObject
{
    Q_OBJECT

    QML_ELEMENT //注册qml的宏
public:
    explicit NetworkHttp(QObject *parent = nullptr);

    Q_INVOKABLE void sendRequest(QString url);//2
    //要有Q_INVOKABLE，这样在qml文件里才能调用该函数

signals:
    void replySignal(QString reply);//4
public slots:
    void onReplied(QNetworkReply* reply);//3
    //槽函数,与m_manager进行信号绑定，当m_manager请求数据成功后，调用该槽函数

private:
    QNetworkAccessManager* m_manager;//1

};

#endif // NETWORKHTTP_H

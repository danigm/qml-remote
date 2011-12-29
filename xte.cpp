#include "xte.h"
#include <QtNetwork/QUdpSocket>
#include <QDebug>

Xte::Xte(QDeclarativeItem *parent) :
    QDeclarativeItem(parent)
{
}

int Xte::send(QString host, int port, QString str)
{
    qDebug() << host << port << str.toAscii();

    QUdpSocket *s = new QUdpSocket(this);
    QHostAddress h(host);
    int x = s->writeDatagram(str.toAscii(), str.size(), h, port);
    if (x < 0) qDebug() << s->errorString();


    return 1;
}

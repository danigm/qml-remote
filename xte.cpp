#include "xte.h"
#include <QDebug>

Xte::Xte(QDeclarativeItem *parent) :
    QDeclarativeItem(parent)
{
    mSock = new QUdpSocket(this);
    qDebug() << "new socket";
}

Xte::~Xte() {
    mSock->close();
    delete mSock;
}

int Xte::send(QString host, int port, QString str)
{
    qDebug() << host << port << str.toAscii();

    QHostAddress h(host);
    int x = mSock->writeDatagram(str.toAscii(), str.size(), h, port);
    if (x < 0) qDebug() << mSock->errorString();

    return 1;
}

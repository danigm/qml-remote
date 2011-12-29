#ifndef XTE_H
#define XTE_H

#include <QDeclarativeItem>
#include <QtNetwork/QUdpSocket>

class Xte : public QDeclarativeItem
{
    Q_OBJECT
public:
    explicit Xte(QDeclarativeItem *parent = 0);
    ~Xte();
    Q_INVOKABLE int send(QString host, int port, QString str);
    
signals:
    
public slots:

private:
    QUdpSocket *mSock;

};

#endif // XTE_H

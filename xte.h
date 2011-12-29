#ifndef XTE_H
#define XTE_H

#include <QDeclarativeItem>

class Xte : public QDeclarativeItem
{
    Q_OBJECT
public:
    explicit Xte(QDeclarativeItem *parent = 0);
    Q_INVOKABLE int send(QString host, int port, QString str);
    
signals:
    
public slots:

};

#endif // XTE_H

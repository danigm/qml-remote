#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "xte.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qmlRegisterType<Xte>("Xte", 1,0, "Xte");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/remote/main.qml"));
    viewer.showExpanded();

    return app->exec();
}

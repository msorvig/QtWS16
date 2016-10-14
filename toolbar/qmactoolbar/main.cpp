#include <QtGui>
#include <QtMacExtras>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);
    
    QWindow window;
    window.setTitle("QMacToolBar");
    
    QMacToolBar *toolbar = new QMacToolBar(&window);
    toolbar->addItem(QIcon(), "Allosaurus");
    toolbar->addItem(QIcon(), "Giganotosaurus");
    toolbar->addSeparator();
    toolbar->addItem(QIcon(), "Stegosaurus");

    toolbar->addAllowedItem(QIcon(), "Allosaurus");
    toolbar->addAllowedItem(QIcon(), "Giganotosaurus");
    toolbar->addAllowedItem(QIcon(), "Stegosaurus");
    toolbar->addAllowedItem(QIcon(), "T-rex");
    
    toolbar->attachToWindow(&window);

    window.resize(300, 100);    
    window.show();
    
    return app.exec();
}

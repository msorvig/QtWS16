#include <QtGui>
#include <QtWidgets>

// Shows a QMainWindow with either a normal (movable) toolbar or
// a fixed unified toolbar
void showWindow(bool unified)
{
    QMainWindow *mainWindow = new QMainWindow();
    if (unified)
        mainWindow->setWindowTitle("Unified Title and Toolbar");
    else
        mainWindow->setWindowTitle("Title and Toolbar");
    
    QToolBar *mainToolBar = new QToolBar();
    mainToolBar->setMovable(!unified);
    mainToolBar->addAction("Allosaurus");
    mainToolBar->addAction("Giganotosaurus");
    mainToolBar->addAction("Stegosaurus");
    
    mainWindow->addToolBar(mainToolBar);
    mainWindow->setUnifiedTitleAndToolBarOnMac(unified);
    
    mainWindow->resize(300, 100);
    mainWindow->show();
}

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    
    showWindow(true);
    showWindow(false);
    
    return app.exec();
}

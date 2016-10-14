#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

class TopWindow : public QWindow
{
public:
    TopWindow()
    {
        // Create the effects view
        NSVisualEffectView *effectsView = [[NSVisualEffectView alloc] init];
        effectsView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
 
        // Wrap effects view in a QWindow controller - this becomes
        // the effects window.
        effectsWindow = QWindow::fromWinId(reinterpret_cast<WId>(effectsView));

        // Add the effects window as a child QWindow.
        effectsWindow->setParent(this);
        effectsWidth = 100;
        effectsWindow->setGeometry(0, 0, effectsWidth, this->geometry().height());
        effectsWindow->show();
    }
    
    void resizeEvent(QResizeEvent *ev)
    {
        // Keep effects window geometry in sync on resize.
        effectsWindow->setGeometry(0, 0, effectsWidth, ev->size().height());
    }

private:
    int effectsWidth;
    QWindow *effectsWindow;
};

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);
    
    TopWindow window;
    window.setTitle("NSVisualEffectView");
    window.resize(300, 300);
    window.show();
    
    return app.exec();
}

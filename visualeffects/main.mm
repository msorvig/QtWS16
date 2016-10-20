#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

class TopWindow : public QWindow
{
public:
    TopWindow()
    {
        // Create the native effects view
        NSVisualEffectView *effectsView = [[NSVisualEffectView alloc] init];
        effectsView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
 
        // Wrap effects view in a QWindow which will be used to control it
        m_effectsWindow = QWindow::fromWinId(reinterpret_cast<WId>(effectsView));

        // Add the effects window as a child QWindow.
        m_effectsWindow->setParent(this);
        m_effectsWidth = 150;
        m_effectsWindow->setGeometry(0, 0, m_effectsWidth, this->geometry().height());
        m_effectsWindow->show();
    }
    
    void resizeEvent(QResizeEvent *ev)
    {
        // Keep effects window geometry in sync on resize.
        m_effectsWindow->setGeometry(0, 0, m_effectsWidth, ev->size().height());
    }

private:
    int m_effectsWidth;
    QWindow *m_effectsWindow;
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

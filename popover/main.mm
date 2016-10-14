#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

// A NSViewController that controls a programatically created view
@interface ProgramaticViewController : NSViewController
{

}
@end

@implementation ProgramaticViewController

- (id)initWithView: (NSView *)aView
{
    [self initWithNibName:nil bundle:nil];
    self.view = aView;
    return self;
}

@end

// A Simple QQWindow subclass that shows a popover on mouse release
class ClickWindow : public QWindow
{
public:
    ClickWindow()
    {
        // Create popover
        m_popover = [[NSPopover alloc] init];
        [m_popover setContentSize:NSMakeSize(200.0, 200.0)];
        [m_popover setBehavior:NSPopoverBehaviorTransient];
        [m_popover setAnimates:YES];

        // Create view and view controller
        RasterWindow *window = new RasterWindow();
        ProgramaticViewController *viewController = 
            [[ProgramaticViewController alloc] initWithView:window->toNSView()];
        [m_popover setContentViewController:viewController];
        [viewController release];
    }

    ~ClickWindow()
    {
        [m_popover release];
    }

    void mousePressEvent(QMouseEvent *ev)
    {
        // Show popover at mouse position; re-using the previosly created view
        NSView *windowView = reinterpret_cast<NSView *>(winId());
        // NSRect position = QRectF(ev->localPos(), QSize(1,1)).toCGRect();
        NSRect position = CGRectMake(ev->localPos().x(), ev->localPos().y(), 1, 1);
        [m_popover showRelativeToRect:position
                               ofView:windowView
                        preferredEdge:NSMaxYEdge];
    }
    
private:
    NSPopover *m_popover;
};

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    ClickWindow window;
    window.show();

    return app.exec();
}

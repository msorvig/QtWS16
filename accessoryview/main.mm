#import <AppKit/AppKit.h>
#include <QtGui>
#include <qtcontent.h>

// An NSTitlebarAccessoryViewController that controls a programatically created view
@interface ProgramaticViewController : NSTitlebarAccessoryViewController
{

}
@property (nonatomic, retain) NSView *the_view;
@end

@implementation ProgramaticViewController

- (id)initWithView: (NSView *)aView
{
    self = [self init];
    self.the_view = aView;
    return self;
}
// override loadView, as per NSTitlebarAccessoryViewController documentation
- (void)loadView
{
    self.view = self.the_view;
    self.the_view = nil;
}
@end

ProgramaticViewController *createViewController(NSView *view)
{
    ProgramaticViewController *viewController =
        [[ProgramaticViewController alloc] initWithView:view];
    [viewController autorelease];
    return viewController;
}

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    // Create and configure native window
    NSRect frame = NSMakeRect(200, 200, 640, 300);
    NSWindow *window =
        [[NSWindow alloc] initWithContentRect:frame
                                     styleMask:NSTitledWindowMask | NSClosableWindowMask |
                                               NSMiniaturizableWindowMask | NSResizableWindowMask
                                       backing:NSBackingStoreBuffered
                                         defer:NO];

    // Add toolbar and enable "streamlined toolbar" look by hiding the title text.
    // An empty toolbar still adds vertical space which the accessory views will use.
    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"main"];
    window.toolbar = toolbar;
    window.titleVisibility = NSWindowTitleHidden;

    // Add title bar left view (blue)
    {
        CheckeredWindow *checkeredWindow = new CheckeredWindow();

        NSView *view = checkeredWindow->toNSView();
        view.frame = NSMakeRect(0,0, 200, 1);
        ProgramaticViewController *viewController = createViewController(view);
        viewController.layoutAttribute = NSLayoutAttributeLeft;
        [window addTitlebarAccessoryViewController:viewController];
    }

    // Add title bar right view (green)
    {
        RasterWindow *checkeredWindow = new CheckeredWindow();
        checkeredWindow->setDrawAlpha(85);
        checkeredWindow->setColor(QColor(20, 150, 20));

        NSView *view = checkeredWindow->toNSView();
        view.frame = NSMakeRect(0,0, 200, 1);
        ProgramaticViewController *viewController = createViewController(view);
        viewController.layoutAttribute = NSLayoutAttributeRight;
        [window addTitlebarAccessoryViewController:viewController];
    }

    // Show the native window
    [window makeKeyAndOrderFront:nil];
    
    // Run application; clean up on exit
    int ret = app.exec();
    [window release];
    return ret;
}

